Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD9818DF79
	for <rcu@vger.kernel.org>; Tue, 20 Aug 2024 11:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724152036; cv=none; b=k8ee7ROnLCiML2lwlStCKDLlvAwbciUJ/FE7f3lfbrmQFKB+SAIlhJJfplsp/RbT2jYqszrkCb0hjFggNh8g+Y74c+G0S1gJoOOagfzqogONmvQxQB8BzTlLeAySk+5ugfzUdBIowoB84r+YqC6tWfp5yELU3sThJxlPF1QDp+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724152036; c=relaxed/simple;
	bh=xIQv4Hd2XG7yFPUcChaM2GkAP/V4+vK9uDoHx6tIun8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X8b6tI98Lbh/KCwr3w0kbGAO6AUwQVROMIq9OjyLFJ1AkRqYp0B8iQPIheUIoa6oviV6W8Tv6eqqxm6PbJygADsEW7RjlCEcE5y/Ud53QWsrj5ZuUz2g/b6NIN8PkDBr0gbzWhIQw/nLDEDulZPLYwVfQmXYNmFlKIlYGjEDTUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWcx77A3; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWcx77A3"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d3d7a1e45fso3094072a91.3
        for <rcu@vger.kernel.org>; Tue, 20 Aug 2024 04:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724152035; x=1724756835; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lA8imu78aVlIEt+tEN70+ohnKj74GYc5QLNv6Inqwzw=;
        b=eWcx77A3SUZOfPNcSb2wieJ86YgOHCkqUhrW+ia7qBt9QXWOcxW/FkAGHxAmcdFmPd
         8BLVTOXjOf/7J/EqeNZeDIta+8F0PJaAWgmy/e+aRQbcRpAwH/UQwATEGH/LagM8sStA
         0uUxBQj+ZToGKrmKMHDTGhu59/dbWWRP4irrqUrhgNZqnId/rZtW270o9sOeJ6K6/kXL
         m7H4ZV3FyGPQ606KCYrekr5m8JXgJdVUXkhtY2lKgw8wq8Al+V2bpWTnNTJGV+SQCK/g
         a91O0jV16TTA6oT518L1UpIMS07XcvMW7iO/PrhxSVingPZTiC5FrLlpqAoXtWEz/Lf2
         KGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724152035; x=1724756835;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lA8imu78aVlIEt+tEN70+ohnKj74GYc5QLNv6Inqwzw=;
        b=Ise8CJN7EETnNMAYbduRVfzwy89eoKBBQAou67mi6C7unDKFlgI+5hgb3ih/sk3/yt
         esJqqLCuR96924byMHtnmn9n2Sq5+W1kZGgGPkI0R5BePV+yhYeu7gnHb2JWOeBZ2bWQ
         eA3K86lwJGmf20VWlavh6yf7mYYEIF/AY9jUdI3vUvwhCcV4TFxGkIpWlwFSigJ/YHsm
         wGzWmdjftAfimBjhcbNniif74bN/49Pwaqko+dpTU7xkGUXetl1r3cX4seYkKTV0JS9U
         YRcCQYm9lHNDp37DbDc0QJK4xUrp/tyXhZ49mDHut9bfZDo+n6TUYTaE7iHizJikFdSr
         SO6A==
X-Forwarded-Encrypted: i=1; AJvYcCV0v/23mk7Qo4ZgceerX1cQsFw/ra8ywYF/v/y1fIzoBn4t4C8DdauOJDqjAFUx8pdGgzqAwxka5+1hFtMX4WHTR2Bb
X-Gm-Message-State: AOJu0Ywl47C+ynMjIr10K2ZOnsFPjPX5yGZ81wvAKv86tdavInn/HhhO
	uGds9CIrp6OKyxCfPncrW+V7a5XW3Rc3Qau4HaoyH6p8JwH28HC9KF6kefVvpj+30q1L68qQtKx
	WFEGbN4RJbRA9iPVYzEzZevA+HIsmIpUciGHrsw==
X-Google-Smtp-Source: AGHT+IEGv4GkS9/5Xmn5Qe1o32DEMg23NGwQyWx537aHmYR1G05RE726Q5rYkQDPDI+8cF4PIw3/wOndUxujJfXSChU=
X-Received: by 2002:a17:90a:ec0d:b0:2c9:8020:1b51 with SMTP id
 98e67ed59e1d1-2d3dfdaadafmr12991528a91.3.1724152034464; Tue, 20 Aug 2024
 04:07:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2747e596-5359-4f32-b3e0-0b2368d37017@paulmck-laptop>
In-Reply-To: <2747e596-5359-4f32-b3e0-0b2368d37017@paulmck-laptop>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Tue, 20 Aug 2024 19:07:02 +0800
Message-ID: <CALm+0cV0GwT5umPRZrZWg4oqXwdjcWz-NkxkhgxQkv=NypQthA@mail.gmail.com>
Subject: Re: One-off rcu_nocb_rdp_deoffload bug
To: paulmck@kernel.org
Cc: frederic@kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> Hello, Frederic,
>
> I have seen this once on Neeraj's tree with a few commits on top (-rcu
> commit 46774278c74f ("rcutorture: Test start-poll primitives with
> interrupts disabled").  But only the once so far.
>
> This is the WARN_ON_ONCE(rcu_segcblist_n_cbs(&rdp->cblist)) in
> rcu_nocb_rdp_deoffload().
>
> Thoughts?
>

The rcu_segcblist_extract_done_cbs() doesn't reduce the count of rsclp->len,
in rcu_do_bacth().  this may cause that after we execute the barrier rcu
callback, before decrementing the count of rsclp->len,  the rcu_barrier()
returns and makes a judgment of rcu_segcblist_n_cbs(&rdp->cblist)  in
rcu_nocb_rdp_deoffload().

maybe can use WARN_ON_ONCE(rcu_segcblist_n_segment_cbs()) instead
of WARN_ON_ONCE(rcu_segcblist_n_cbs())

Thoughts?

Thanks
Zqiang




>                                                 Thanx, Paul
>
> ------------------------------------------------------------------------
>
> [18839.499664] ------------[ cut here ]------------
> [18839.500993] WARNING: CPU: 19 PID: 100 at kernel/rcu/tree_nocb.h:1061 rcu_nocb_rdp_deoffload+0x292/0x2a0
> [18839.503545] Modules linked in:
> [18839.504443] CPU: 19 UID: 0 PID: 100 Comm: rcu_nocb_toggle Not tainted 6.11.0-rc3-00459-gba3eb80edec7-dirty #1553
> [18839.507190] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [18839.510002] RIP: 0010:rcu_nocb_rdp_deoffload+0x292/0x2a0
> [18839.511451] Code: e9 3c ff ff ff 4c 89 e6 48 89 ef e8 98 0d e1 00 e9 3b fe ff ff 90 0f 0b 90 48 8b 83 c0 00 00 00 48 85 c0 0f 84 0b fe ff ff 90 <0f> 0b 90 e9 02 fe ff ff e8 e1 60 e0 00 90 90 90 90 90 90 90 90 90
> [18839.516469] RSP: 0000:ffffa05a8049be30 EFLAGS: 00010006
> [18839.517908] RAX: 0000000000000081 RBX: ffff956c5eaaf480 RCX: 0000000000000000
> [18839.519849] RDX: 0000000000000001 RSI: 0000000000000287 RDI: ffff956c5eaaf5f0
> [18839.521804] RBP: ffff956c5eaaf5f0 R08: 0000112269aee7fd R09: 0000000000000001
> [18839.523747] R10: 00000000000020e8 R11: 0000000000000000 R12: 0000000000000292
> [18839.525623] R13: 0000000000000000 R14: ffff956c5ea2f480 R15: 0000000000000001
> [18839.527557] FS:  0000000000000000(0000) GS:ffff956c5eec0000(0000) knlGS:0000000000000000
> [18839.529917] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [18839.531556] CR2: 0000000000000000 CR3: 0000000001cfa000 CR4: 00000000000006f0
> [18839.533495] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [18839.535395] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [18839.537322] Call Trace:
> [18839.538006]  <TASK>
> [18839.538596]  ? __warn+0x7e/0x120
> [18839.539491]  ? rcu_nocb_rdp_deoffload+0x292/0x2a0
> [18839.540757]  ? report_bug+0x18e/0x1a0
> [18839.541805]  ? handle_bug+0x3d/0x70
> [18839.542837]  ? exc_invalid_op+0x18/0x70
> [18839.543959]  ? asm_exc_invalid_op+0x1a/0x20
> [18839.545165]  ? rcu_nocb_rdp_deoffload+0x292/0x2a0
> [18839.546547]  rcu_nocb_cpu_deoffload+0x70/0xa0
> [18839.547814]  rcu_nocb_toggle+0x136/0x1c0
> [18839.548960]  ? __pfx_rcu_nocb_toggle+0x10/0x10
> [18839.550073]  kthread+0xd1/0x100
> [18839.550958]  ? __pfx_kthread+0x10/0x10
> [18839.552008]  ret_from_fork+0x2f/0x50
> [18839.553002]  ? __pfx_kthread+0x10/0x10
> [18839.553968]  ret_from_fork_asm+0x1a/0x30
> [18839.555038]  </TASK>
>
>
