Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5D5C13C;
	Mon, 22 Jul 2024 17:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721670956; cv=none; b=nDkUEiKAd+VQ/WurjU+vPPIM+bYiFL4+NbJlrYHTGRkP0cobZzOtMO1PDJRk4MaVyXI2JLcBgXYBc7aZxH9WlZXl+UWsrRakxZNI6PXAHkX3itvk8wTY4ZkCOQTiVp42hrBNFwhtL0nC3MT7J6c4S3Is3/74kaFpU3FUu0hcCLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721670956; c=relaxed/simple;
	bh=mpvVW7mQf44kawB7sLbXdkOzx0RI3DhyJUPJZUZD0xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRzCJiC/X8bkrV67zywqJs0ORGJvTXAZpLtD6CYB+2WV4xrIiHSEl5Emu2nZIxSvjjgQTsXNmeXyR4F8pOMnihRqVzEcNyNjckPTODx/kr1VgcUq05B930OgicmJZLIYbRSbCeNucRNXmptAZMmuTisZcYrKW2eRh3co/Tj38wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wh1iTVXH; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wh1iTVXH"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7037a208ff5so2631018a34.0;
        Mon, 22 Jul 2024 10:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721670953; x=1722275753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2OArvbFTZD4MOvzzr92whknsjou7hxu1jymE3tQovA=;
        b=Wh1iTVXH9UTCnCvZcNGzayfrxdvYOe01Qsou0dtXUI6BSBZgtfl8xZyU88v+++Zf04
         0e30rrRWMNvCVtzCUdyAiXos7/xXcG4JFpVgWYd7kgxW7vbkhC1BrDOKLrnZpQktsg9/
         ZJjj/sp2MRToV+zWAmk10+mMxFsSZ9s+yVrUUtHLgXaszkdveF70vvFccnhlTerM1QC8
         EqrQxOpqEOu41tdoPngNJhkMjLW8qsG2zRoiB+DNhkBuwelIirT8qPOZlER239qSIcJY
         jBso6vcl7znjqEBbiE0pO2oEbcFEudfXfKRTvqECLkVrte/l0goX4tTp4xKV2naAS0nc
         ov8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721670953; x=1722275753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O2OArvbFTZD4MOvzzr92whknsjou7hxu1jymE3tQovA=;
        b=LOGcgakRTPXTgDyu0nG3DbhzEs/itnLiF19UQZrczZjuT2wQWIrpEOvtpP+Gu2peIB
         xKuI5o1bAu0mGNLAef51cVuZK3O0/NutxvXBLEryiwTkRlIkHVazkfbowlCKo2qqlqAG
         fIx9Rokc3x+lGPB8gb+8e53GuLBxZ5nfFV4E920LgQo5QJjX/2QJb9yd5CiwFhHOxquw
         iOSqOZn460EGkUKFESyhJIdtRW5PPGECEXVkswf9ud1o7r0RW1xyufC3IBl5ByP97THt
         gGiQuoXsECBvgOu7bRpiFXBAH6/X14QOo83vOGQb4h+5FumiE27z7hiuTaI3jTYzUtG0
         ZEvw==
X-Forwarded-Encrypted: i=1; AJvYcCWfH/QIqDAZ66P6Wb+eaLyLOFqEp6gVew8ULuTxR54NgYT1IfV6pYuqT1ddwsARu+RRiMKe+XuZ2jkcCqCjbM1ANFEV1HI6S8+yy1LWGZt/Ktw/8uTrgKOIls1QTimYh97c
X-Gm-Message-State: AOJu0YyP3c3ELlZ689Y0aJOgd7t87ToduqzOz55jMVOx6vwc/UbmrYE3
	KAHoCT+yArkZcPvmBk1jLO246AO5YrLWsXeJdGAR4qjz6PsaXjsFzoZ6yA==
X-Google-Smtp-Source: AGHT+IG2wWckv/bYUTsp44vHKqVOV2hlrx5gFuw/hdumf9VFX6t0hYykOIgZzdXhT5HH9/rnYFOsZg==
X-Received: by 2002:a05:6830:3c8d:b0:703:6f25:96ab with SMTP id 46e09a7af769-708fdb2ca0emr12985189a34.16.1721670953639;
        Mon, 22 Jul 2024 10:55:53 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7acb0f114sm36523856d6.146.2024.07.22.10.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 10:55:53 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 21EE11200066;
	Mon, 22 Jul 2024 13:55:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 22 Jul 2024 13:55:52 -0400
X-ME-Sender: <xms:KJ2eZoObw-7YPKOzvrWwdA4tS6nedGfj46XCqz5A22sJadfrvA63xA>
    <xme:KJ2eZu8Eu6XOSP228wzPA0jC1JYe9becc0VIMJ5WY2CcezadCm3aA9YuIJ7EJPy-6
    1tYypUiSSHHUe6euw>
X-ME-Received: <xmr:KJ2eZvQrxFzJZQzpZ4wPglQVJile9YsKMpl2st5L6w6jckWQ6EjfAf37FwOo1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrheejgdduvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeekvedvheefheeihfffgeehgfeuhfekfeffhefftedtffdujedtkedtfeeh
    vefgueenucffohhmrghinhepshihiihkrghllhgvrhdrrghpphhsphhothdrtghomhdpgh
    hithhhuhgsrdgtohhmpdhshiiisghothdrmhgupdhkvghrnhgvlhdrohhrghenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvg
    hsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheeh
    hedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:KJ2eZgtb1yCd1JcU0MRG6v6Ghae0_fm2GB_CzxGH4YrhzyF3Tigweg>
    <xmx:KJ2eZgdq5SuyZAVB1fZCYfpVOrLab1sinUwUz3TVuXgIUuoJ3a_dYg>
    <xmx:KJ2eZk0LSx__Gy2QbUx-pfmnngwu_Cq_iKTl8KQUxFepNnJxob1B_Q>
    <xmx:KJ2eZk-PtGKU0vDXr6hoAteCQGSmZkHGkOmnigDUKWa0OseYj1Mpiw>
    <xmx:KJ2eZn_LJucG1db1rpH3PbrnokWwzRrHkBmk4KBlonIuq71q5bq4sGa4>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jul 2024 13:55:51 -0400 (EDT)
Date: Mon, 22 Jul 2024 10:55:33 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Z qiang <qiang.zhang1211@gmail.com>
Cc: paulmck@kernel.org,
	syzbot <syzbot+784d0a1246a539975f05@syzkaller.appspotmail.com>,
	frederic@kernel.org, jiangshanlai@gmail.com, joel@joelfernandes.org,
	josh@joshtriplett.org, linux-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, neeraj.upadhyay@kernel.org,
	rcu@vger.kernel.org, rostedt@goodmis.org,
	syzkaller-bugs@googlegroups.com, urezki@gmail.com
Subject: Re: [syzbot] [rcu?] WARNING in rcu_note_context_switch (2)
Message-ID: <Zp6dFQc6yyL3bqRa@boqun-archlinux>
References: <000000000000d0e3b5061dc16993@google.com>
 <2897a6bd-6c7d-4b9b-8891-27051df45f8e@paulmck-laptop>
 <CALm+0cWP3=HJfdbQcRNf-StdfFEJw66HSX4i8a+fTek3zR=ORA@mail.gmail.com>
 <29449e47-d40b-4d01-94dc-630b2a92279b@paulmck-laptop>
 <CALm+0cXx4LADq0XJeUP6M0KwY_ok9bx7YLOz1BSX09D3XrvUAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALm+0cXx4LADq0XJeUP6M0KwY_ok9bx7YLOz1BSX09D3XrvUAQ@mail.gmail.com>

On Mon, Jul 22, 2024 at 02:42:10PM +0800, Z qiang wrote:
[...]
> > >
> > > This should be caused by this modification  (commit id:
> > > ca567df74a28a9fb368c6b2d93e864113f73f5c2)
> > > when tsk is null, miss invoke rcu_read_unlock() for NS_GET_TGID_IN_PIDNS.
> >
> > Very good, and it looks like that to me as well.  Would you like to
> > submit a fix patch and see if syzbot agrees?
> 
> I see there is a c test
> program(https://syzkaller.appspot.com/x/repro.c?x=17a3c349980000),
> I will run this test on my local machine, and then make a fix.
> 

FWIW, syzbot provides a way to do tests automatically:

	https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patches

But looks like Christian already fixed this:

	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=280e36f0d5b997173d014c07484c03a7f7750668

Regards,
Boqun

> Thanks
> Zqiang
> 
> 
[...]
