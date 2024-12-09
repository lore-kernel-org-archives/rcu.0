Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90947189B85;
	Mon,  9 Dec 2024 08:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733731559; cv=none; b=G3OFUXUe1j+0nxgXhJPcDtkEwNqdhuUPso04/E79t3Y9XyOt5+Ny107wVDdvBG//OEHLRm0sSuLfeSpjzjQwJT6oSmc1k6mvk9CCKTThxGgH4xFQl+R1LDR7oIqVoMxHfFMgzr45xi52Y8an974WgQNCRD6v39a4hjXgYoxPaLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733731559; c=relaxed/simple;
	bh=8VAJpynRiWBMl5iR56OUJ338MCAOSpnRZVFQ4bXM1A8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=YTCSzW+zkmLtLxQqypeVa4JWVCGMvPyJhxNoFMTJXsn9w19FRwNXa4P0sKN1Vn9gWgLtZkEQUk8igjEH1QjhZ2lLv9+N21HzU6xbh3VbN4oW+k3Fw6uKzefY5jS5g+SuRoeDUej+mWHekD6f1Y1EGc41V5sdjEozwsVmqaN1wOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihwDkNse; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihwDkNse"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cfa1ec3b94so5110347a12.2;
        Mon, 09 Dec 2024 00:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733731556; x=1734336356; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6y43Q2xPqwGg4tRNaDtdiBPvlzFzNCfebPr6OjzzNjc=;
        b=ihwDkNse5G9YGJ+IohIy1ZK5blAWAjH95tjT86EGIuOjgzpHfspsxc1goSDrLLZyHU
         Is3R95T9zN12gic8XrXbIOFU7NBN1XeqhQs7c3o7gKvvliri96N4upvEMN0uiGcNXdKT
         MlO8t2HjVdKT0ThTanYOQI7WK9OGKdfSDKJzuHoHI1iUGSiDjqeMZWSzHRDa+Lw5qPDP
         N9W/3i9VPj2Yx1BNOQq7lhNEevo46/TSKrJDHdgsdUmIi/81p2zyfxhccOS87wiKFad0
         OLvSnK9musk8LozhrMTw1s1aQBu6zzfQSY7Uxvf9sUDnlQOIlfoakSC04uQY1FdKmnBZ
         HZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733731556; x=1734336356;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6y43Q2xPqwGg4tRNaDtdiBPvlzFzNCfebPr6OjzzNjc=;
        b=YxdXTc8zc1aeJmzM/KeB13niuybDrBkQsFkjw5X4Cm1COlCoaLQOXUsC3Z9tifaK4H
         LcfiI/1UHgiUDHnRhSCUaNhrFoj7iFgmfBXR5BhA8Ks6XRnMbSLELCId/vyh3qlasmCj
         Y8dn9kQnXzTUH6iLH3H88sZGxXdkNQH3OEd2/OWbwW4gupk+CQv5m6a2Xy+rftxte/Kq
         wI7A9b7d6Thu0dTZ9/Y7yh8OZDHBkRbTQDqV7NXq1zgIkvflT160TlF24trjK3/PcLkG
         +pZog/l9g3yAs71ZdymmboAb8XiEddgimhEClzlj62d/g/vYzmyCPjwdBG6sa0xbwMc1
         vVUw==
X-Forwarded-Encrypted: i=1; AJvYcCVq0FO2bfZ7sF2YVT6tTbBm1wJ4Zsjy7tAn3fAJACI0hDiNRm/sRuslHtQNvzwCgQ6ANqXU@vger.kernel.org, AJvYcCXo22wrTKy4Fy4Tly4dQiiepZLH+QrPd5JKmDUoJkj442oZ1uPdof0khDrLW7aIx3YZQEToLi8DsS0HNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfpMoHohoJ8tNzLY4C/dVWX7AZFXKccYjEK+cQZFVm2V3dzrkZ
	65ierXef5dhOSuE1JdHq1cFCNsVMR9fzcKNpQVJMPzGx3DB05o2LvNom8zwHGgk+8FlC10iXT09
	znV3C6jGe3XZZf6BztUwJu8ZDUsw=
X-Gm-Gg: ASbGncsH3UXkkDUuSsWNxebf/zdseAPgFhfEjO7VDlmY42PUWuGXJ4pfV/u3/zsgRQj
	x/zdjrssosKOdIRWCMQXu3JiH9T9RHw==
X-Google-Smtp-Source: AGHT+IFpi7NGTscyjc4gURiDqgB8TZ2pmuuLPxMvodo4uyY6tll5Y7g/PzcesnJG2mTC0GifK1iGwWqgvGC8Yf2d7nk=
X-Received: by 2002:aa7:d3c8:0:b0:5d3:cd5b:64a9 with SMTP id
 4fb4d7f45d1cf-5d3cd5b656dmr8451957a12.34.1733731555662; Mon, 09 Dec 2024
 00:05:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <51ce38fe2fa34ec79ad07a96feaea597af07bac7.camel@physik.fu-berlin.de>
 <CA+=Fv5RaMF2ohojG+U0MG-dpLHS4x-Tc41+fOLZwrWqu7T0L0A@mail.gmail.com>
 <CA+=Fv5QH1nUO1D1=Osqic6mNN6vLxiLqvNA4D9uAUgZA_w+7Tw@mail.gmail.com>
 <0b338882a82c3f505407cb313b89a2c7f891d982.camel@physik.fu-berlin.de>
 <CA+=Fv5RDcgm4YSX1AcpOgLvL=XXKyA=71ZasbJSc7+79Kh_Xpg@mail.gmail.com>
 <d9330edfca0fb34c69a68c56924fa0b074b26d29.camel@physik.fu-berlin.de>
 <CA+=Fv5T9nrQjGHOR+42tfgT723TJGgyVqBY7CwY4L-gYSoWTag@mail.gmail.com>
 <c661a771a86267c158d7f2eba1494fe94350fb06.camel@physik.fu-berlin.de>
 <CA+=Fv5Rxrwn0SEMgjufJcxSaB0_gOiKBjXuZnSKzgKakDHeCOw@mail.gmail.com>
 <CA+=Fv5R+8y2hCq7p-xo5qZ0CyinR_0aAndUkoEAweCVs_95SMw@mail.gmail.com> <Z1YpKFQGtMWF3yy3@creeky>
In-Reply-To: <Z1YpKFQGtMWF3yy3@creeky>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Mon, 9 Dec 2024 09:05:46 +0100
Message-ID: <CA+=Fv5Q=f-6y=EhZhG2XfZB0O=m+yOiv+gmtmMABVQZieKdwbQ@mail.gmail.com>
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
To: Michael Cree <mcree@orcon.net.nz>, Magnus Lindholm <linmag7@gmail.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, paulmck@kernel.org, rcu@vger.kernel.org, 
	linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Maybe, maybe not.  Building 6.11.11 with alpha-linux-gnu-gcc-9
> (Debian 9.3.0-22) fixed the null pointer access in the scsi
> subsystem, and finally I have a bootable system! (Tested on ES45.)
> But I now get a null pointer access when network driver loaded:

Very interesting! Can you provide a full stack dump? interested to
see if this is the same issue as on my system.

>
> [   34.501935] e100 0001:02:04.0 enP1p2s4: NIC Link is Up 100 Mbps Full Duplex
> [   40.692361] Unable to handle kernel paging request at virtual address 0000000000000000
> [   40.799783] CPU 1
> [   40.799783] kworker/1:2(158): Oops -1
>

Have you tried passing rcupdate.rcu_normal=1 as boot parameter
to the kernel? That allowed me to bypass the network interface
problem on my system.


> Cheers,
> Michael
