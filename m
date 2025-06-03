Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3731225792
	for <rcu@vger.kernel.org>; Tue,  3 Jun 2025 21:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748985427; cv=none; b=q6DKL9vcKsP7OLztdL9MoMgmRiMy1NVLnp8RkfMxkzF/P28p1H15eo45pTApJlnFrHeLju5YKrKfDOoLyiK8Rqfrag4XsjTeFMWW56tThHNhAHwIj0kTIF+h4kFtW4wa55kV82NYvSUAXi867QbkEjMhXjouOVXDd3avzE3BzQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748985427; c=relaxed/simple;
	bh=rWC3dTyak2lA/e9nsxwmwdV1wQJmz6NhlPDDAt9bFfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NsxJdaXLVo6ZlTmfcUPYXGRLLFSeM3gvFSCEoxO+RVai4ITelPFw5Evi4GmFxgGLWwDTHSs4JZsLcEMhaagabC4Ao3yNQYAM5dhDLeULKeRsmazyNCxOtbtc3ARRbTkxkDt5Zu4YNqhhUf3cA5GxZ5044cQ7vAKX7EhAnKh74VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfDe8YOX; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfDe8YOX"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6fada2dd785so43035086d6.2
        for <rcu@vger.kernel.org>; Tue, 03 Jun 2025 14:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748985424; x=1749590224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PzkKlHVfAyJ7rCnL2n+wPGaVbmjinOyb/0ctxJekCmY=;
        b=RfDe8YOXj0LQuo0+mQJfWdiGO1MiTX4Ufd9qgUJ+WikDuLjFeQX+W/oiOVcmQQb7DO
         dtuqcAjsAWLJ6oBIlINeZQ3tjdhUODAVyvD6aSV1YhATnzz7ZD6/H3cW08lWDVhuaPiq
         P84ECgCVcaJsYmbNUR8GrcyOZlQc3CBMPBYupLo0F8jMNlmWCGHJXs2gR8qQDcRz+4hj
         qLlrCyJMOjcKJ4NAAEg1z19tTunI4nl0rUBKwBf83idhZXh7JahAXlKo0HakD3G6hdK4
         v+YVBebshWcZXdPywsiV6dzkx6TFCk9ISOTvXGGYJj5TjvSW7c+Z9q79NCEFcRv6gXOY
         ktnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748985424; x=1749590224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PzkKlHVfAyJ7rCnL2n+wPGaVbmjinOyb/0ctxJekCmY=;
        b=kOK18/pgrd5xGXlxwK5lHLyWAjbuXe/H0patZ2ykd30gk7Lx0WtI0Tym0+z2vaeK1n
         dlKmnDfJzHf9M7WhZwk5m05n41sMMfYzmdvrsFsHyq+3dimeTLv32oqmJwPoSx37XUqX
         z6piaPIlNdRtcwdOCTPWYx12dK+DXKy+lmRku14m+BcDmeaOdUKCzQ5SaCgTyRFXIMwj
         kJ7Rws93p9O5tm9CJrCYdHE5unRwGrS7faRtHyU6fH9nfebGJJosCCbp0rGic88yksvq
         S10di2yX10U4mXxlx69zFGAllY+CUKq55hcKsmtUMKemQghp2VhL4IxcgGDhghXe4+oM
         4/DA==
X-Forwarded-Encrypted: i=1; AJvYcCU4XRvvQdmfrPQPpEVMxtEIoep1ge2hIm+CiwwFauxHWtNFWylBRdlzZ6+OqhxmaUsnN2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTu+wdGs/FxgsKDWVZAxA+AhsiX/s3Z27tOBUgAFGO92/51EHT
	63AsdHhlNhVwUYa/i4PiIjYBfLP1mr+qzD8PdTJdQxS7FEmV1BrgwYCy
X-Gm-Gg: ASbGncuWyY/dNycnHDyYqkJtWqIOp5GZi9VduKyoV1iSD/ZZv33yLIw9jlhbGGlIQYs
	hp/r6gEeRQQv4AE9iqvHzviKwNPbSyMG9VjKXOVH2Fta1xb/jLS+R/2f0eBPnMRnNhFi3OkX+oC
	h9CGr1YVm2W8uYxDdZwQMvtw0gGS3v+NTp8R94iMnHaK9fxH7/KB3ffF98K8HEkpjtFrXB23XuV
	1ntoSmQJD6PNeRpr6qzI/EiiXwLObXR6W0HIdd59Gj+FfW9hpo0hIt6Bkm9GPK9q6y3xW6YCdNZ
	JQEgnjsHY1Iza/x6LcbyJfxC+f2RWBEwTnLilup6u40O2RoC27bVSjAy7AANxeyxbUOFCls5KYQ
	a08usTAXMD0hIdHRg/LnyH7aibtxzhpfZYj2/A5dL6w==
X-Google-Smtp-Source: AGHT+IEhLuxFZNRdS5V5iDE6Ni+hfReMm1Cb/NXCkhoN0Wk1+zUL1TcGBX3FBsMG1dJewFcQ6LOe3w==
X-Received: by 2002:a05:6214:3003:b0:6e8:98a1:3694 with SMTP id 6a1803df08f44-6faf6fd1ba6mr4207206d6.8.1748985424529;
        Tue, 03 Jun 2025 14:17:04 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac6d33abdsm87018036d6.14.2025.06.03.14.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 14:17:04 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id E9A681200068;
	Tue,  3 Jun 2025 17:17:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 03 Jun 2025 17:17:03 -0400
X-ME-Sender: <xms:T2Y_aHTkDAg-XLcQrVtZQuEMuKoaSQzaVJFONb7uRhcKMRMOQvkW8w>
    <xme:T2Y_aIyZo32nbtR47sODaU7mTOBk-7OZnjdRBtQ3FbgtDcy0gY7kbCOQmCZL1Vv_D
    Dr2QErSPDyT3oRbkw>
X-ME-Received: <xmr:T2Y_aM2ADGcLfmh-8-y_zuxQXSvKou60n2_RKDAwUOuKFV-HFvgc5cSOxbs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleei
    vedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepjhhovghlrghgnhgvlhhfsehnvhhiughirgdrtghomhdprhgtphhtthho
    pehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvvghrrghjrd
    hiihhtrhdutdesghhmrghilhdrtghomhdprhgtphhtthhopehurhgviihkihesghhmrghi
    lhdrtghomhdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepsghoqhhunhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:T2Y_aHBx6uPAI0abzSuUSXTGu9tHyvSQTHFXJaJaLUXbC4JFdSBXWg>
    <xmx:T2Y_aAixQJxnB6odRjhcK8LBrtE0wY9pqckBAEndHJily0MklplpMg>
    <xmx:T2Y_aLos30qNlms2Rzi5tzI-9wYGAbMe1nQwu797mr9Omx_rvUHEug>
    <xmx:T2Y_aLi4Sl2n9wyi_ek4aQZ3aORmsBJI8x0iuUU3wI5nZU4CCYCM-g>
    <xmx:T2Y_aDTDFr1GJoFoSQKDKmdcIm2YQFSn23iMHgHc2Q_7BU2mQZUbIDDb>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 17:17:03 -0400 (EDT)
Date: Tue, 3 Jun 2025 14:17:02 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, frederic@kernel.org,
	neeraj.iitr10@gmail.com, urezki@gmail.com, rcu@vger.kernel.org
Subject: Re: RCU patches in flight
Message-ID: <aD9mTodFDv1rkYlX@tardis.local>
References: <b7a341ba-cd4d-468a-9d66-4aabe70a747d@paulmck-laptop>
 <aD9exNsGkKng3ac5@tardis.local>
 <4e2211c9-d0ed-4c51-be9d-763c9eef370a@nvidia.com>
 <4741ab72-7150-41c9-b214-b4c0f883ae3c@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4741ab72-7150-41c9-b214-b4c0f883ae3c@paulmck-laptop>

On Tue, Jun 03, 2025 at 02:11:25PM -0700, Paul E. McKenney wrote:
[...]
> > Paul and this one too? I dropped it from both my PR and my rcu/dev branch:
> > Subject: [PATCH 5/5] rcutorture: Fix rcutorture_one_extend_check() splat in RT
> 
> Good catch, but I do have that one in my -rcu "dev" branch.  Mostly
> because I was lazy and never rebased on top of your final pull request.
> 
> Which reminds me, it is time to get Joel shared-RCU privileges if he
> does not already have them, correct?
> 

Agreed.

> > >> The above commits must be ordered after this -rcu "dev" commit:
[...]
> > > @Joel, do you want me to sync this rcu/dev branch to the rcu repo then?
> > 
> > Yes Boqun, go ahead and sync it with rcu's /dev. Thanks.
> > 

It is synced already, and a snapshot branch named dev.2025.06.03a.

> > Also how do I get added to access the RCU tree?
> 
> Boqun, would you like to send the kernel.org request?  Just to get them
> used to requests not coming from me?
> 

Will do.

Regards,
Boqun

> 							Thanx, Paul
