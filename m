Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1903038DCC
	for <rcu@vger.kernel.org>; Mon,  4 Mar 2024 16:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709570016; cv=none; b=ndDnFaSQLYR5Z8M+ooXeDY461/ZDNfQv7/DG6mmb2GRiTYNbsTR0VNn7YjPP4yPrpQ1BIM5+XKx3qM0i3Z02+8YDTnmVgBYXrZTHEvY9FYVABGNp78zccjWSWrVNv0/pbDMLZjvCHWanmTm4KXbfftQxSPHBWYxFjKM2/cUag8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709570016; c=relaxed/simple;
	bh=PEdDUWg7dGydDSmkTPDGbLYydFx5ClH6+MRqw3JPebk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Udb8MD9hhW6kgRLGgTn6A9Cwaljn1+tMzZVomAeO2oPukv7e/PZt3lJ/B3gotKT8bJqErYDscgoFbeSFgvN/WZ25UPzrlxmIoHHngF6vULYkCQsQ3necCl3vJr9XPC5lx6mLXLL/vaI3s5BLqv2bOD4R67Q3O9uV2ADHJJ/2S7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hk4lGpN5; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hk4lGpN5"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-78822e21a9dso52146685a.2
        for <rcu@vger.kernel.org>; Mon, 04 Mar 2024 08:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709570014; x=1710174814; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DcUO1lxMKpF0JBcplNZQH+WoHS8Rf7TjgwTIs09Ka8w=;
        b=Hk4lGpN5R5qk+8M29SNbsWS6TxTXvRNjAZR7PRi62koPUAJ3cy4U8dvXa3f+ECGoSC
         +faS0jxyp10D2rsvkrFP3WdMaMdVlD9a6eUA9R8Lxe3DwJF9c894MX8ruIOwr2084cqF
         MeGldiOmVUvCKTE86CVFdh/W2jon9Jg9tXIpWMTDpx1exQfdRTTE/71OOT37v8XKwNij
         T6M5wHJAbmuvHwWcKk31fkmaEv9zTRYy0JvPkgd9hXmEwB1WvOxRuc73XK0ISRa7Tnn4
         wjFp4GdPXvJiSV1Xa74ptdl9Pz172q1goAsid7oxF95gH4vp53J6x0X3OsfVC4hmJwt6
         /pCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709570014; x=1710174814;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DcUO1lxMKpF0JBcplNZQH+WoHS8Rf7TjgwTIs09Ka8w=;
        b=mEh7JhujlCoxDHEDtSPcIw+24aWg2pk8+nNXBOYuQx9UKi2SmNvGaltKdSBS/VcLOI
         B23TIGwJv/6XRFDwWEBMB0S0CNsIrVBEeaopkEDTRqm02V3PoPfg7Yd6xxR21uOBRDEx
         sTA8Zx3xv7Ndu5J3VjEC2wQZEpktaxMUuW7Ep/lZ99/9a+gQr35wSWWtT5rAWSBeVEuc
         m0/0W00nGUlDVCQDIzy/Tvegt5CGMwb+jGxz42CHn19nQJ/521e5+VJR3O5STaLtiKro
         xrSKwNwc1NLQqmmXEyCSZkRwkUiDKcAddgxEcQSjwx37qo4bA8QQx8d/e/re3694GxWn
         WW1A==
X-Forwarded-Encrypted: i=1; AJvYcCVQkMZ+PU/noSr5onD3CuYH7ALP5919PgRrpmbkNUo11MU5luXfTqZOO2HKrucbiB/4llU6V/nnkk+qPG4SnHimVdZv
X-Gm-Message-State: AOJu0YwShwaWH5ZJN4CgGfEMfZ7QZdtOnLl6h7AlfPdE/Hhq0zsjqeTo
	Yrwzzj95e30nz+Cup11nT2elAYG/p148AWTBD5HTt5WyEUOl2n9UaqC3cWag
X-Google-Smtp-Source: AGHT+IF6/7JP3RVluHDJvWpk3WODBdUL4FjnIEfpks4U84zIykaW1gVBpBWz0pMnndZ29HTLXPzzyw==
X-Received: by 2002:a05:620a:1a1c:b0:788:4f8:ef80 with SMTP id bk28-20020a05620a1a1c00b0078804f8ef80mr12359059qkb.16.1709570013873;
        Mon, 04 Mar 2024 08:33:33 -0800 (PST)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id o27-20020a05620a111b00b0078821c4207bsm1836561qkk.115.2024.03.04.08.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 08:33:33 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 25E901200068;
	Mon,  4 Mar 2024 11:33:33 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 04 Mar 2024 11:33:33 -0500
X-ME-Sender: <xms:3PflZcq0nibiM_n6s2WNjiPli7MdWyqgqb_SZJ0GBJTh7g0ObXFoJA>
    <xme:3PflZSqSLiZGFTiDssk2Yg5aitOvDKIaLb59UjC-8Q1PS-EV9eyUv3QSNO-1NGNka
    SrDPWfGWAe7WIDaWQ>
X-ME-Received: <xmr:3PflZRNQPjuADLPtNgIvslS0jcPRToBJMY27k5B5YOt-QYByDT0Xjawv1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegkeegtedtleffkeeftdevleeuieduveejgeeikedvgeekudefteefieei
    vdeuleenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:3PflZT6W4MUa1-QW1S4ARGV-KhDos5lGxdtKcia1c-SxRbklH8-6kw>
    <xmx:3PflZb5wB4n-tqA9toQXH-YTr6Q6W-FkdO7FniIaCN0FOe9sHUj_4g>
    <xmx:3PflZThRhDsHkoJAVU2CpKxryRMG8FLzqR1GKVlVeCmlGGG7KmN3og>
    <xmx:3fflZdmlQEWIEDEXsoM1oujdECwWgO9IkTuc-kJ4FKttE9IMpuyB4RxkjRM>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 11:33:32 -0500 (EST)
Date: Mon, 4 Mar 2024 08:33:31 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Max Boone <contact@maxboone.com>, rcu@vger.kernel.org
Subject: Re: Advice sought on RCU stalls on ARM64 WSL2
Message-ID: <ZeX327aMIrthOXbs@Boquns-Mac-mini.home>
References: <1a5d96d6-2057-44d9-a4b0-8771c46032fb@paulmck-laptop>
 <3718bb-65e38400-d-5cd53080@68830111>
 <99a0fb2c-c936-405f-85bf-847c61531bd5@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99a0fb2c-c936-405f-85bf-847c61531bd5@paulmck-laptop>

On Sat, Mar 02, 2024 at 04:19:17PM -0800, Paul E. McKenney wrote:
> On Sat, Mar 02, 2024 at 08:53:54PM +0100, Max Boone wrote:
> > 
> > Thank you so much for the quick reply!
> > 
> > ​​​​​​I haven't filed a bug with Debian specifically as I'm running the linux kernel built and provided by Microsoft and Ubuntu as OS on top. If it helps with the search I'd gladly run Debian and file a bug there, but will still need to build my own kernel as WSL requires some modules (such as HyperV storage and sockets) to be built into the kernel instead (meaning =y) of as modules (meaning =m).
> 
> Ah, if you built your own kernel, then you are your own distro as far
> as kernel issues are concerned.  ;-)
> 
> 							Thanx, Paul
> 
> > I'll stick to using the rcu list from here on to avoid spam, thanks again!
> > ​​​​​
> > On Saturday, March 02, 2024 20:43 CET, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> >  [ Adding Boqun and the rcu list on CC. ]
> > 

Thanks, Paul.

> > On Sat, Mar 02, 2024 at 07:59:08PM +0100, Max Boone wrote:
> > >
> > > Dear Dr. McKenney,
> > >
> > > For a couple of years now I've been the sometimes frustrated owner of a Microsoft Surface Pro X ARM64 device, which has been getting progressively better as more vendors start targeting their builds at ARM64 architectures but since the introduction of the device there have been issues with the Windows Subsystem for Linux (not more than an opinionated Hyper-V VM with extensive tooling) locking up and hanging. 
> > >
> > > When this happens, traces like the following are dumped in the kernel messages:
> > > https://github.com/microsoft/WSL/issues/9454#issuecomment-1942222109
> > >
> > > When watching your talk "Decoding Those Inscrutable RCU CPU Stall Warnings" you mentioned one can feel free reaching out when bumping into such issues. Building other kernel releases, switching off-and-on modules and playing with the RCU grace period times so far don't seem to work for me (or others in that thread).
> > >
> > > Anyways, I don't really know where to start looking and the call stacks aren't very informative (to my eye) either. I'm hoping you might help me find the direction to look for the root of this problem.
> > 
> > I am assuming that you have filed a bug with the Debian folks, and before
> > doing that, searched for similar bug reports.
> > 
> > At first glance, this is because things were stuck here:
> > 
> > [ 967.115632] clear_rseq_cs.isra.0+0x4c/0x60
> > [ 967.116433] do_notify_resume+0xf8/0xeb0
> > [ 967.116960] el0_svc+0x3c/0x50
> > [ 967.117537] el0t_64_sync_handler+0x9c/0x120
> > [ 967.118323] el0t_64_sync+0x158/0x15c
> > 
> > So including these function names (clear_rseq_cs() and so on) in your
> > search for similar bug reports would be a good idea.
> > 
> > I am unfamiliar with that code.
> > 
> > So I added Boqun because he works with Linux on HyperV as part of his
> > day job and has a great deal of experience with RCU. He will likely
> > have quite a number of questions for you including exact versions,
> > Debian bug number, the results of your web search, and so on. He might
> > also know an ARM person to get involved in this.
> > 
> > Or maybe he knows the solution off the top of his head!
> > 

I haven't seen this issue before, looks to me the stall is caused by
clear_rseq_cs(), which is basically a put_user(), and I don't have an
immediate theory, could you share the kernel repo and configuration you
used, so that I can see if I can reproduce this? (Note I don't have the
exact device as you do nor an ARM64 Windows system with the exact
Windows build you are using).

Regards,
Boqun

> > Thanx, Paul
> > 
> > 
> >  
> 
