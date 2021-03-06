function axisAngle = quat2AxisAngle(quat)
qnorm = sqrt(sum(quat.^2));
quat = bsxfun(@rdivide, quat, qnorm);
angles = 2 * acos(quat(1, :));
s = sqrt(1 - quat(1, :).^2);
sing_bool = s < 1000*eps;
axis = nan(3, size(quat, 2));
axis(:, sing_bool) = repmat([1;0;0], 1, sum(sing_bool));
if any(~sing_bool)
    axis(:, ~sing_bool) = bsxfun(@rdivide, quat(2:end, ~sing_bool), s(~sing_bool));
end
axnorm = sqrt(sum(axis.^2));
axisAngle = bsxfun(@times, angles, bsxfun(@rdivide, axis, axnorm));