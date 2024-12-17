Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3698BF8;
	Tue, 17 Dec 2024 06:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734416624; cv=none; b=FRwP/gZi5hylje5UrrpVd4rKh4RutyHnKEy88OWW0T7h3N0NiaHz26MUNKdiICsoAz17ZbQHnpjjYnt2wK8JjsGsg77i9Js2DQmqa0MbnDgcfGdXFCK0OQrfEqK9sPvkx8VkcVtH48WwnDPgT1eFO/MUvK+thJf2deRRP05eDdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734416624; c=relaxed/simple;
	bh=DB1nMc2aS1sv7wbjRQZtPB4peFy6BniBWp7iMOQGaPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=MaUG9xX1K/ORmtFHEvZf7uPmjQ9iEDCcGRcHIz29B8l6ZOSVgHwK9EToDvMNarkIw7BC9YMX2tMI4sYJWJuRL2NFSumuuWWmbIBrGYdeSlMyJkEz7IaJ73ittyEbKc3f3pDrhKQBf/UKpnzTZpTP9+Uf1NpG3XunTrNSmvxs1Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZR4PDjU; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZR4PDjU"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d41848901bso8752454a12.0;
        Mon, 16 Dec 2024 22:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734416621; x=1735021421; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0GPJNFZ7S9lalwFYkHEenO/fNgF5uj9F+p91WlDzm8I=;
        b=IZR4PDjUl0IArDmPqs3h3VEFKb/emmkeIC1AEzA88hYx4BedJ5O28TI7VF15Ks7p8k
         /8vAn33pHb8uQS//QY2aKuv8kHZi5Z7A7d47pwlAa5O2TQ7z0H1lbX4fJ7gUwP8vlU1t
         Am1C0NgsPdpAe6aK/PEWnRO1KAV++DklJLLWPZmeuANLCHnJP6o800VgDRzjOavIk4bj
         KcKYMD68ZAIP8lP34/lrRPEr3R/nMIKQTPU8B0vC8Bj8QC8Q5IPPCVzYtXGZWUWRRu8L
         e+5q1qJfQNuL5uxBxteno554/QgD/M2SDzfEWcBya2JSSRfQg3Nc3jgERQgllIT+8w2I
         0ptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734416621; x=1735021421;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0GPJNFZ7S9lalwFYkHEenO/fNgF5uj9F+p91WlDzm8I=;
        b=FBo5c/TowXPZ66jf1kxuUQdS5EWygPT1Yz4bqfmm7AqNIYceJEn+aVy3ORxYAiDVBJ
         /rIvzHi+VNTdjs17IELb48oX8ohLVtHeXfPvvdBNK7Tytvew3TTI5OwT2HUiPAH/GDZT
         pGBXY50TaUROW4zR3H6m+WcjGLlWjlyfqBJ3D7mJ0U+lyqEs0L1Pa0ZmHzqj0ykMO91p
         C9wuHnDLx11F/zS91UrB2I3AwsWfvMTsPOHhDMukptLPS85oOM27HEPf/jEKD9hy5Jag
         xhBOuTlhMi1jui06tomGKkLe+Ge9sVgB83fxeGxhT50GIE7zQekt5GFy27jFpPK1D35q
         KD0w==
X-Forwarded-Encrypted: i=1; AJvYcCUF/ntznDAXfaZ/1o3p/9OcI5wp8cwJvS08o334hgwduyByJQMwVYr8mJKki0QGyZg30mcv@vger.kernel.org, AJvYcCXok4Nb+l9B1xuSp4hRwAClVOAGhxpAhB6UR5uJUZr89e+tJs24U2DLu3iGSmUMtGN8GwbLOP8MDSPkNA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXwiF7hvB0Ag3Lqq405I+vUQ71Ta2Vg0YGJBy9p+SK9QAY934C
	zJ7kAA4YsC1FHrtBD4waG8dhwZMgvK0Hr1DQp++SJlczB7vnQ3iG/Rya9NJV+ch54Rjcl3a7b0E
	Z5KqxKyYNelH/eG73Qy3zt+MpPCM=
X-Gm-Gg: ASbGncuSAv1JyfQJR7RBAKJdbsqDEkGsUA10qGMkXcRkHs/eWqwXex4tRCH1kE79upY
	jKhQ4JRCGugIPJ1AZlcuR6Rpduo3WyvZz0jIbSNI=
X-Google-Smtp-Source: AGHT+IEmBD05usW/r0+W3ArOr0cuJdo93BkLrXkFzKBMtdN43lTaKSasQeKliwcEIOGPIm3IZWn6Qvf3kcUURFZkeY8=
X-Received: by 2002:a05:6402:3594:b0:5d3:d79a:6d6d with SMTP id
 4fb4d7f45d1cf-5d7d52caff4mr1880592a12.0.1734416621395; Mon, 16 Dec 2024
 22:23:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+=Fv5QH1nUO1D1=Osqic6mNN6vLxiLqvNA4D9uAUgZA_w+7Tw@mail.gmail.com>
 <0b338882a82c3f505407cb313b89a2c7f891d982.camel@physik.fu-berlin.de>
 <CA+=Fv5RDcgm4YSX1AcpOgLvL=XXKyA=71ZasbJSc7+79Kh_Xpg@mail.gmail.com>
 <d9330edfca0fb34c69a68c56924fa0b074b26d29.camel@physik.fu-berlin.de>
 <CA+=Fv5T9nrQjGHOR+42tfgT723TJGgyVqBY7CwY4L-gYSoWTag@mail.gmail.com>
 <c661a771a86267c158d7f2eba1494fe94350fb06.camel@physik.fu-berlin.de>
 <CA+=Fv5Rxrwn0SEMgjufJcxSaB0_gOiKBjXuZnSKzgKakDHeCOw@mail.gmail.com>
 <CA+=Fv5R+8y2hCq7p-xo5qZ0CyinR_0aAndUkoEAweCVs_95SMw@mail.gmail.com>
 <Z1YpKFQGtMWF3yy3@creeky> <CA+=Fv5Q=f-6y=EhZhG2XfZB0O=m+yOiv+gmtmMABVQZieKdwbQ@mail.gmail.com>
 <Z2ClSlwznfuk8Uwr@creeky>
In-Reply-To: <Z2ClSlwznfuk8Uwr@creeky>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Tue, 17 Dec 2024 07:23:29 +0100
Message-ID: <CA+=Fv5RaqHL6MJjvhF-mn3CVY10e=2QqFBSVO6YXLUJ7WV9zGQ@mail.gmail.com>
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
To: Michael Cree <mcree@orcon.net.nz>, Magnus Lindholm <linmag7@gmail.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, paulmck@kernel.org, rcu@vger.kernel.org, 
	linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> [   36.896465] Trace:
> [   36.896465] [<fffffc0001049c8c>] process_scheduled_works+0xdc/0x420
> [   36.898418] [<fffffc000104a740>] worker_thread+0x0/0x3d0
> [   36.899395] [<fffffc000104a8f0>] worker_thread+0x1b0/0x3d0
> [   36.900371] [<fffffc000104a740>] worker_thread+0x0/0x3d0
> [   36.901348] [<fffffc000105705c>] kthread+0x17c/0x1c0
> [   36.902324] [<fffffc000104a740>] worker_thread+0x0/0x3d0
> [   36.903301] [<fffffc0001011198>] ret_from_kernel_thread+0x18/0x20
> [   36.904277] [<fffffc0001056ee0>] kthread+0x0/0x1c0
> [   36.905254] [<fffffc0001011180>] ret_from_kernel_thread+0x0/0x20

Very interesting, both the RCU bugs that I've encountered, kernel
kernel threads have been at work just as the stack goes corrupted
The stack trace is therefore often incomplete since return addresses
have been overwritten by some one of the threads, some information
on where this actually happens might therefore be lost on the stack
trace.

Magnus
