Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8943A5588E;
	Fri, 24 Jan 2025 06:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737698782; cv=none; b=dh686+M+PdxXZ0cg87eCJ6p+6DVqixvrI9kf5CRe43GcaNJa4ul8Uos4HOd9bho2hJQb0cHRFW9vuq3uc7pkuVIuMHKSvVFWNqwem6Zpb2eW51BOWsAdCfC3SY4EmFtPchxyr0EFlJvW1I5dO8tRYbi5x6SiHd9VxsnXliRYhT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737698782; c=relaxed/simple;
	bh=5RtWOBiu0z0MlmBFKAeRVozYWldGTfWTRtvIt1V/7CE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G5M2os97apNvqbV1+XH/F2lrR7dTEhEwZjaBWMH3Qr/ZrIo2DHXlne+U/5ASWoFsSUJmmLrCR06YNxcQFFdCBUolz5xIwAB5/O7oElbQPExHjOtIfXsx1iMhCYDMrR05ROWJFCW/ZJCcaClqQi9dOik+0XAtQE+mcpypXAviNgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aoPDqKoY; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoPDqKoY"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3cf094768so3365637a12.0;
        Thu, 23 Jan 2025 22:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737698779; x=1738303579; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RG4j+svmASbLImMpUcZ8t8gAUFeLss6a+rNfigwqj5A=;
        b=aoPDqKoYeM0eCmH4pMeTKBHulvVsafIKFLV0Zh77pY8/dCfl4m6quYiuvGrdspkGdz
         xNg68rVtgGZ8isykcFhJgnLmdm1OobTj5XaVqRpyxiClv1agloGIK50lBVfz662vBur1
         nyG7ZHgvd3HlRqqZuvVLbjDGi3SvkVscE4mznm1vf8+yXCV9dQsCGqX0k/x8e3/sCSWY
         KnBf9rfxN2YU23LvYc4dSNjYmy4kIo3qThD+N78MttIU+NvPCoJCJl2rqklOxw3/iCV/
         sFxJi1rd6fVOfvkzpSu4QyQtOdDSdRNv751dGnxLcr0hrEzdxCo9FGf9fwiVX5asuG0v
         nGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737698779; x=1738303579;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RG4j+svmASbLImMpUcZ8t8gAUFeLss6a+rNfigwqj5A=;
        b=Uv+9d0s7f8RIf8pSutbzEFRsJsXOoHE1w1629ZcevcuEl9dyC9ppP+7wX5CSKiQGLQ
         yy37WGItRMMmfkW5QqMF5ICKxAVmr/h8r/0b9J9AN9QIzgpVkctF17p4PQn5Ma5Cm18A
         Seapx/ZL+Dw2ia/tPc9sck6bXE/A4iLj1+Qi3U6hnQyZb1Wwp0p4RKDK/Saiew2eZWwB
         CSh5l1I6+zlc2owqNgBtdQZwvic0hfgGnYCaAmTUbrAsEXSqDprvxtU4fP0drYYFwjnr
         suusSUptpvkD0OeG2PcFjATT62OH/ZAFDLmOfy5hHGhOKajuYMTwnwi00GKiwyFJDdpW
         wqPg==
X-Forwarded-Encrypted: i=1; AJvYcCUWo1AtKEF2Cp8DvJB34ar5EGGnWJs2phSo7NVMOERBEkOy2i0kzF63rM7H/hSF5aSIZujk@vger.kernel.org, AJvYcCX+eoX75GYmDeISzskh3vMdeL7b4POcc3YXBp5ipYLrFtq4GrQ27hr9RPz4msRSloPOj4QQLSdU9uPCmA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxltt/moh10HtxDcSAJK5sClJ5xoTEZ3xN9uJvlvGnqbiqd5d9s
	oaVztdbspnXbL9r3UBJyj5umghDrw67vB6dt1VOLOldzY6ZMr/lr5D3UrYxeBZNVZCRNZNuwZXP
	UtZl6HPlYtpJ5zDXz1sLzqsDBpdA=
X-Gm-Gg: ASbGncvQYhOJ5OsoBizXcq2luLpFZj5TR00mWgNPzvh/hMQvSZFUwH7MknP41IKna6K
	DG+2Dnejgs5QaXogNRptYDK7jDFGQs+WZPMe6CTZVXZuKEzuTMtcWK+WObjhgJws=
X-Google-Smtp-Source: AGHT+IFq9oDds6G4G+lCXW4ewNcqetr0yFoE6Xlpu5bzQrC10H8j958krCHEz4JZ/vWF5PVrtfz1A0WoV/s6kYGdkxo=
X-Received: by 2002:a05:6402:1d4e:b0:5db:fcb0:e52b with SMTP id
 4fb4d7f45d1cf-5dbfcb0e88amr7034843a12.24.1737698778432; Thu, 23 Jan 2025
 22:06:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+=Fv5TJhDrrxG82=MNPFEFFwKD4NDYyB1u32ZvnGv6Ma0h_Nw@mail.gmail.com>
 <alpine.DEB.2.21.2412271452100.20821@angie.orcam.me.uk> <CA+=Fv5SW-N+5KzsnVdHvy406-p+g7giUbt626xwDduy6xjaPkw@mail.gmail.com>
 <CA+=Fv5TtOQkDMPnuPrPGcB0VGhUHUDqe5=Z+ovd5x5rBJ-Hsjw@mail.gmail.com>
 <alpine.DEB.2.21.2501122348510.18889@angie.orcam.me.uk> <CA+=Fv5Q9UxeSP0U10d281Nbm3agyFgpwyY95+d2pAWVWJP=2Yg@mail.gmail.com>
 <CA+=Fv5RU946-r5S8hZKTF4w20s82Oc-JDe-pCa1W7zjr6nEoag@mail.gmail.com>
 <CA+=Fv5RntE=Z=PgYYxBDLTDES6aWkg-+yqEPPDjv-E7GCcoufg@mail.gmail.com>
 <alpine.DEB.2.21.2501201317060.27432@angie.orcam.me.uk> <Z4-jgMJgbVriLaCr@minute>
 <Z5KMHoA7GlHJyUU_@minute> <alpine.DEB.2.21.2501232306270.27203@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2501232306270.27203@angie.orcam.me.uk>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Fri, 24 Jan 2025 07:06:06 +0100
X-Gm-Features: AWEUYZlW-p1L1-ejmCcyg-JvuN5aGR5JaJM3VWsa0tHfyWDpnxb_Txt3F8c9LIg
Message-ID: <CA+=Fv5SkXgOPdGD-ytreeS8OR=FVW3MuSbOz1_MoZtO56E6=CA@mail.gmail.com>
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Ivan Kokshaysky <ink@unseen.parts>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Michael Cree <mcree@orcon.net.nz>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, rcu@vger.kernel.org, 
	linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>  Umm, this is a part of UAPI, and the change in alignment changes the ABI
> (think padding where `struct pt_regs' has been embedded into another
> structure), so AFAICT it is a no-no.
>
>  But the only place I could quickly find this should matter for is this:
>
>         /* ... and find our stack ... */
>         lda     $30,0x4000 - SIZEOF_PT_REGS($8)
>
> which should be straightforward to fix:
>
>         lda     $30,0x4000 - ((SIZEOF_PT_REGS + 15) & ~15)($8)
>
> or suchlike.  Have I missed anything?
>
>   Maciej
>

I left my ES40 doing "emerge --update --newuse --deep @world. Which
failed and I'm seeing stuff like this in the logs:

conftest(29098): unaligned trap at 00000200010005f0: 00000000bb65ed99 28 2
conftest(29098): unaligned trap at 00000200010005f8: 00000000dab6f47f 28 1

Unable to handle kernel paging request at virtual address 535853452d4d4245
CPU 2
cp(19064): Oops 0
pc = [<fffffc00004ac9dc>]  ra = [<fffffc0000497630>]  ps = 0000    Not tainted
pc is at __d_lookup_rcu+0x6c/0x110
ra is at lookup_fast+0x40/0x200
v0 = 535853452d4d4249  t0 = 0000000000000000  t1 = fffffc0003780000
t2 = 000000003a01009f  t3 = 6465637379730035  t4 = 0000000000000000
t5 = 0000000000000001  t6 = 0000001400000000  t7 = fffffc00a8e8c000
s0 = fffffc00a8e8fdb0  s1 = 0000000000000001  s2 = fffffc00a8e8fdb0
s3 = 000000011fe45840  s4 = 000002000096408d  s5 = 000000011fe46060
s6 = 00000000000003ff
a0 = fffffc00fb5260c0  a1 = fffffc00a8e8fdc0  a2 = fffffc00a8e8fdf4
a3 = 0000000000000000  a4 = 0000000000004050  a5 = 00000000021ab34f
t8 = fffffc00fb5260c0  t9 = fffffc00a8e8fdf4  t10= 000000146e2931da
t11= fffffc000a52b089  pv = fffffc00004ac970  at = fffffc000a52a800
gp = fffffc0000e9c980  sp = 000000001a40800e
Disabling lock debugging due to kernel taint
Trace:
[<fffffc000049cd90>] path_lookupat+0xb0/0x260
[<fffffc000049d620>] filename_lookup+0x90/0x180
[<fffffc000048ce5c>] do_readlinkat.part.0+0x6c/0x200
[<fffffc000043a0e8>] __handle_mm_fault+0xb18/0xd60
[<fffffc000049cf78>] getname_flags+0x38/0x270
[<fffffc0000494bd8>] path_put+0x38/0x50
[<fffffc000048ce34>] do_readlinkat.part.0+0x44/0x200
[<fffffc000031095c>] entMM+0x9c/0xc0
[<fffffc000048d7f0>] sys_readlink+0x30/0x50
[<fffffc0000310d04>] entSys+0xa4/0xc0



/Magnus
