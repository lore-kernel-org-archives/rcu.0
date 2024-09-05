Received: from mx-lax3-2.ucr.edu (mx-lax3-2.ucr.edu [169.235.156.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D6984D34
	for <rcu@vger.kernel.org>; Thu,  5 Sep 2024 02:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725503006; cv=none; b=qENgVmI32uAwZgAUArwhrKgVEuyS9drkMEUatngSv6K7Qymh11Bf8b6qXUigykKBWGpx+rKNGaiXHyo5kIX37MaIcYpkVegeSRPaUTOIDua6wiXdRCa4ia7U0y8ZAvftBp2AsPCX2SBX+XdOqalX3S5y/1RjOnz0iTMqcu9KC0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725503006; c=relaxed/simple;
	bh=lhw3OBQuK7/2O1QLDwTTdW8+9of6164bBZpADs1sncY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cSL/lz2PtQGpb8hIk1YoT3iQFFNaGaMDZYqAeo65XCqj66zIg2fRckblqDrJijm4IZ+zaqFnG3kxmmENMQOgplLr74M3pmEzUNdBAYK9MCchqsMj58BHNF7F3n7/Yrg+QDTjmc7qJaafjk0Vavh2oiviRoKXEeH0w99pHmqcYzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=ZY7K6ULj; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=oKSu0/Wc; arc=none smtp.client-ip=169.235.156.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="ZY7K6ULj";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="oKSu0/Wc"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1725503005; x=1757039005;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:references:in-reply-to:
   from:date:message-id:subject:to:cc:content-type:
   content-transfer-encoding:x-cse-connectionguid:
   x-cse-msgguid;
  bh=lhw3OBQuK7/2O1QLDwTTdW8+9of6164bBZpADs1sncY=;
  b=ZY7K6ULjMsjqu163YO6IUl08fp3dEbXHZcBgAf+lu3Ii2Pvy3N/aNFyE
   80xV7wgWoUCzm2RlebFK5dRif4ksMd3pUj83XC0RJ8UUzYnhpp+3e5ah3
   JF/DiUTGmoh4Ai6wKgstEj3TgYk8oOTpu0CgD843o/wfFiWK4S7DterZW
   +5004cXEBiIUUbe8++cze6qATm590D3rtpYpik8TH0Er5AET7CM5Gwd8x
   p09XruIuMUZVwjiUSQ6/Nv3o9UBRCUcvoLH5arNELmbm8PR2S3oGg238G
   BpkoeYzuqdqttnD01J1CYjEyufQAwmbl1a/9o1pBLLsy7JoaDRQRwhoep
   A==;
X-CSE-ConnectionGUID: bGrWZLkFS3K7FeyW/rAeZQ==
X-CSE-MsgGUID: elV0JqEmQbq4Fxm8hheoJQ==
Received: from mail-pf1-f198.google.com ([209.85.210.198])
  by smtp-lax3-2.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 04 Sep 2024 19:23:18 -0700
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7175ef3e4eeso328789b3a.1
        for <rcu@vger.kernel.org>; Wed, 04 Sep 2024 19:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1725502997; x=1726107797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYDHcfMjZvkDiDOXakZvxVe+vma0YTXAPDxxJz3Bl3o=;
        b=oKSu0/Wc2OuvYB++yXFEYEMiL1GyiLPQdpUzmmpfxmk+Wx1B3ZW6RCKOHzmiwumUiO
         YZZChimUIjAQ+UU7LAl81frXRpGRptz2rgyjaIUQPE1e5cgU94/5REfa5jEJp5P+cqug
         RX4QxgfUWRh9uLxPGPsFaRncIa3K/1UKs9Bts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725502997; x=1726107797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYDHcfMjZvkDiDOXakZvxVe+vma0YTXAPDxxJz3Bl3o=;
        b=rt6MGHBhNCE5ukioEPLm3yD8poctO/nm1wBguxd1dzI9sKHSqYv9HGhnAiBk1a4GqR
         g83VSmgKhvzBVoR23F7WXDPvWlk31aF6EDDx3lp5IpFFhHuTFEuqu58OemJPIAOHdjW7
         7aOontmyqsy3D8/aGFlmVZV49t8b0ZD8FkQgX3JqsfKWmknWwDxNYb1QnZxpkZOD3dYe
         Q9BcqYAF9DxvyfawJYqZ8cwdKTqwbmEagSO+0MfXDYcm+PbL/L86ypXdlnnGBU2dONyi
         4E1uwyYV4yeu8BUFAsx0f8ZFzmPuhANAFc8o67fPUMI40zffCvUHZh1e7D11WKX6qAva
         bszA==
X-Forwarded-Encrypted: i=1; AJvYcCWyKfoJKHpFt4zzBt4C3yyimRcI1L6aJsLxO9z5WVnFbbFEDm/fy61k3Ti8TlgtvRmQ0ys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs0NThfTEYZalCDJ4dZwr6vnvtrMQE0PHXQiBEF3cDfsBognnw
	v3EwlDr1BLihxGnpaP2tY/iTsQKURymBoTaNPpuyZlEaS7uBsdaRBPjIL3S0ZKxxAL4rFB1sOGd
	xkfBeKx0rw9Hk1Es2d5vX1O7XNshzKoasEwZs890kkixS8f6zasN5BmlKl7Sr0d/8gqCUOU2f+J
	vLUcqCdphPsqurK2PBnGrK4vmLwg==
X-Received: by 2002:a05:6a21:3213:b0:1ce:d9a2:66ed with SMTP id adf61e73a8af0-1ced9a26870mr14829838637.48.1725502997472;
        Wed, 04 Sep 2024 19:23:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEU8EZ271k5Z+ERiwyouSa4tPgCyjiar3qkx+0DIkWhii/uNad7/cCyb/VjsF4omGSKnp7GAtYK9v4CGZR3FAE=
X-Received: by 2002:a05:6a21:3213:b0:1ce:d9a2:66ed with SMTP id
 adf61e73a8af0-1ced9a26870mr14829823637.48.1725502997040; Wed, 04 Sep 2024
 19:23:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALAgD-7JNKw5m0wpGAN+ezCL-qn7LcTL5vgyBmQZKbf5BTNUCw@mail.gmail.com>
 <ZtAunXBPC4WElcez@pc636> <CALAgD-4kr9MLE6jSF7pXFX9msd-NWFL8mrscvJAOecNWAYL4RQ@mail.gmail.com>
 <ZtieQFsSiALVVGld@pc636>
In-Reply-To: <ZtieQFsSiALVVGld@pc636>
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 4 Sep 2024 19:23:04 -0700
Message-ID: <CALAgD-7WAY6FwTNGdt0BQ2S99Nr+yJ5XyWhA_L_SsbkKsHBrFw@mail.gmail.com>
Subject: Re: BUG: WARNING in kvfree_rcu_bulk
To: Uladzislau Rezki <urezki@gmail.com>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org, 
	joel@joelfernandes.org, josh@joshtriplett.org, boqun.feng@gmail.com, 
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, 
	qiang.zhang1211@gmail.com, rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Here is to set up the reproducing environment:
https://github.com/TomAPU/Linux610BugReort
We tested it, and it can reproduce.

On Wed, Sep 4, 2024 at 10:52=E2=80=AFAM Uladzislau Rezki <urezki@gmail.com>=
 wrote:
>
> Hello!
>
> >
> > Here is the config file:
> > https://gist.github.com/TomAPU/64f5db0fe976a3e94a6dd2b621887cdd
> >
> Thank you. I was not able to boot my box using your config file. But i
> enabled all needed configs in to run your reproduce so it does not
> complain on below warnings:
>
> <snip>
> urezki@pc638:~$ sudo ./a.out
> the reproducer may not work as expected: USB injection setup failed: fail=
ed to chmod /dev/raw-gadget
> the reproducer may not work as expected: 802154 injection setup failed: n=
etlink_query_family_id failed
> <snip>
>
> sudo modprobe raw_gadget
> sudo modprobe ieee802154
> sudo modprobe ieee802154_socket
> sudo modprobe hci
> sudo modprobe hci_vhci
> sudo modprobe mac802154
> sudo modprobe ieee802154
> sudo modprobe ieee802154_socket
> sudo modprobe mac802154_hwsim
> sudo modprobe adf7242
> sudo modprobe atusb
> sudo modprobe at86rf230
> sudo modprobe fakelb
> sudo modprobe mrf24j40
> sudo modprobe cc2520
>
> and even after that i am not able to get any "WARNING in kvfree_rcu_bulk"=
.
>
> urezki@pc638:~$ uname -a
> Linux pc638 6.11.0-rc2+ #3827 SMP PREEMPT_DYNAMIC Wed Sep  4 19:37:22 CES=
T 2024 x86_64 GNU/Linux
> urezki@pc638:~$
>
> is it easy to reproduce? Am i missing something in my setup?
>
> --
> Uladzislau Rezki



--=20
Yours sincerely,
Xingyu
