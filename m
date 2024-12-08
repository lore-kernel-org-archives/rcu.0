Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F201DA23;
	Sun,  8 Dec 2024 21:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733693985; cv=none; b=FWWv4s3gpC8TKGQ7jZJOQdUN6iFKiTqxZqiODfAAyAwe2js78Dz/AEOa8HnvQqCvdeMKqDC7HziEbxJdg4J4+kYb2qINdKwrRBGcPy+fyQiCVwZhFRETLyH3no8EBJZhzjyVgGlfVviIWA2O9jO9L2g4EBz113YsKJ6SXDp3fRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733693985; c=relaxed/simple;
	bh=d/Ku4C/SF3fFpM2C2SQMc9y5BoLu4tN7amlsOH46UVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bokOtCcT9IQ3Xgwvi6Xv2Ie57npIfVja1DaVSm5K4V3093oqi73ojP8LsD9e1rcH6XT+UnTg3ScdYuWOzbJAFBTB782ClhN7nyR3DV9lWn+3k69RA3GxL9e05/6uoYB9UCSxjOeSXW1qGE1VhlE2kCrtRSZCkh1mah9sDRfhOeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjLo9WCo; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjLo9WCo"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cfa1ec3b94so4660365a12.2;
        Sun, 08 Dec 2024 13:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733693982; x=1734298782; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d/Ku4C/SF3fFpM2C2SQMc9y5BoLu4tN7amlsOH46UVU=;
        b=FjLo9WCo/kt872NrOd8NjEMKBQLiU6dgxFDC836anxPOztjDUrCY1iOWbMYAJutjIC
         LGfCTrRyuO8TB1SbyowcQFGzc9yNHR2pB2D9/a9sskZ4dp7kLtV9bseqfhNuDA9e0svK
         0lxa9PTYjyImKToCLOlIT7ALsQCJl+sSytqMWnZuaNcvKYb+L38Klafp55mgjM6x6RGk
         eAvSDxNUx6voMwU8KCxlHGxfifzrOyfuqDisEpNOhqwF9wIUgrJDCWnxcFGXsypKdcRY
         kxXOgWCiusMDBoO1FN+TxTDJgCwvYHDMB3ZwveNNRhi77LcvYVs7wE1ALgjIblM3yDnC
         YvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733693982; x=1734298782;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d/Ku4C/SF3fFpM2C2SQMc9y5BoLu4tN7amlsOH46UVU=;
        b=Edv+3H0Hb/zrDK0jgFLbmeERHGXQeV4eaucoSIK4JMfA5BA23eTPR19benHTbZs9cj
         rTzqY9TrsCj9rmoeaANhsnnzL+JXzi4mREA4vRAhxFHAQl44/qAfCzjDnXFLOTJo2k3L
         lEzR4RkLXioVoVniA79us0f6DEHyv7YnljdjjLfhDGRj47HKwlNKgIVNWPcbyIaiVwwQ
         uvx9X5iskQGZRgUDO4vk53h31pC4pJHUPTkKv8TD+h4W7YM2CJqv0mBs9okj/IYpRL+O
         s1LRlDC0weW1w1bp++d3hacs7YtoQ0sMJeHrX/DzKckl4aWhwEUnGKGhqqFRhTCd9bsA
         N5YQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/ufgaLWRQMnykKylIKQIU6MqyMZINVcIHoz9auNDjYDg7YvqRJ2eY6xqBFORajJsfyFpQpkMK7+qc4A==@vger.kernel.org, AJvYcCVEtGSNnnMvl85x+Mw9wPAktfzjW2xC/rgw+a04Mevm/r49U27dZB9lFNb8yklNhi6aoxYL@vger.kernel.org
X-Gm-Message-State: AOJu0YwVWnXUk27IgNQylEfpemB6G8j0tConm/QSAMYnsxDSctC5xd7c
	pjEOpJ5sT8Fw/9Tl5u/WUHd1zycFHMpMVBTxkpkBYN+ExTBTyN3TR3jeH0lUyPOpU+n3I+HIyWs
	++73QdRZzJ7r2tu3GZObPAJdeAQCkdtnD
X-Gm-Gg: ASbGncsie2Tp2IFRlJ3x5djmLVIpGh6avGW3/2ArsgL8Mq56rc6c3VsoMBjxmhM9VdB
	56HnWzXU0EAMErOcnZEUwi6g1Dbs7wvzA
X-Google-Smtp-Source: AGHT+IEoUhHaTa2zK3w/K9P0Yp0jDaBSFHxMyZD1ftO7NtVW0Y/i84qkZ0SLAnN3owtL1r3PbJuHBDmbBzFUfcUmlqk=
X-Received: by 2002:a05:6402:4316:b0:5d3:e8d1:a46 with SMTP id
 4fb4d7f45d1cf-5d3e8d10ceemr5866620a12.30.1733693982151; Sun, 08 Dec 2024
 13:39:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+=Fv5R9NG+1SHU9QV9hjmavycHKpnNyerQ=Ei90G98ukRcRJA@mail.gmail.com>
 <f1561626-fde6-41c0-9d45-87a6a7b13816@paulmck-laptop> <CA+=Fv5TMZ1bckob2VZ1AaNwdU3R+5a8REKg4aZR8novx7+dj-g@mail.gmail.com>
 <8e365392-0e0d-4d78-bae7-69f27c8350f9@paulmck-laptop> <CA+=Fv5RKEC6Vabh3bnJfF7D377qL0PTNkWeqSEWqK9DE5GunrQ@mail.gmail.com>
 <51ce38fe2fa34ec79ad07a96feaea597af07bac7.camel@physik.fu-berlin.de>
 <CA+=Fv5RaMF2ohojG+U0MG-dpLHS4x-Tc41+fOLZwrWqu7T0L0A@mail.gmail.com>
 <CA+=Fv5QH1nUO1D1=Osqic6mNN6vLxiLqvNA4D9uAUgZA_w+7Tw@mail.gmail.com>
 <0b338882a82c3f505407cb313b89a2c7f891d982.camel@physik.fu-berlin.de>
 <CA+=Fv5RDcgm4YSX1AcpOgLvL=XXKyA=71ZasbJSc7+79Kh_Xpg@mail.gmail.com>
 <d9330edfca0fb34c69a68c56924fa0b074b26d29.camel@physik.fu-berlin.de>
 <CA+=Fv5T9nrQjGHOR+42tfgT723TJGgyVqBY7CwY4L-gYSoWTag@mail.gmail.com>
 <c661a771a86267c158d7f2eba1494fe94350fb06.camel@physik.fu-berlin.de> <CA+=Fv5Rxrwn0SEMgjufJcxSaB0_gOiKBjXuZnSKzgKakDHeCOw@mail.gmail.com>
In-Reply-To: <CA+=Fv5Rxrwn0SEMgjufJcxSaB0_gOiKBjXuZnSKzgKakDHeCOw@mail.gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 8 Dec 2024 22:39:30 +0100
Message-ID: <CA+=Fv5R+8y2hCq7p-xo5qZ0CyinR_0aAndUkoEAweCVs_95SMw@mail.gmail.com>
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: paulmck@kernel.org, rcu@vger.kernel.org, linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

some updates:

I've been building gcc from git and this is what I've seen so far:
(GCC) 14.2.1 20241208 does NOT work
(GCC) 15.0.0 20241208 (experimental): works!

Seems like this bug gets fixed in the 15.x branch!
I need to find the commit that fixes this...

/Magnus
