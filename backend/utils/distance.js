const lojaLat = -25.965229; // Latitude do centro de Maputo
const lojaLon = 32.573110;  // Longitude do centro de Maputo

function toRad(value) {
    return (value * Math.PI) / 180;
  }
  
  function haversineDistance(lat1, lon1, lat2, lon2) {
    const R = 6371; // Raio da Terra em km
  
    const dLat = toRad(lat2 - lat1);
    const dLon = toRad(lon2 - lon1);
  
    const a =
      Math.sin(dLat / 2) ** 2 +
      Math.cos(toRad(lat1)) *
      Math.cos(toRad(lat2)) *
      Math.sin(dLon / 2) ** 2;
  
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    return R * c; // distância em km
  }
  
  function calculateDeliveryFee(userLat, userLon) {
    const lojaLat = -25.965229;
    const lojaLon = 32.573110;
  
    const distanceKm = haversineDistance(userLat, userLon, lojaLat, lojaLon);
  
    const baseFee = 100;    // MZN
    const feePerKm = 20;    // MZN por km
    const maxFee = 500;     // Opcional: limite máximo de taxa
  
    const totalFee = baseFee + (distanceKm * feePerKm);
  
    return Math.min(Math.round(totalFee), maxFee); // taxa arredondada e limitada
  }
  
  module.exports = { calculateDeliveryFee };
  