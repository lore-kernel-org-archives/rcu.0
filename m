Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DAD1DFF7
	for <rcu@vger.kernel.org>; Thu,  1 Jan 2026 08:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767257216; cv=none; b=W84y1txflKlXW7h4PAciP75ijBC5Z5kuUh7tXqlj2iFEVI695VLOZ1MIdAVRGQ7bfoxOfZvTdadjCbHYRkBG5IgqBXzK2c6cCFm675B/S9WFj0BEFiyeZQreyurgxz6sVsj2+9VmlnKRqQ1MRZsg36sAV9H2q0JuCS17+eCz6eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767257216; c=relaxed/simple;
	bh=UjQPl1kVqcPuGIAG4jOC9q/hLboTJ1+w5oZgQv3cwtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HkEntuq5gpzkL9f2zIh2e326WvLNmsyLyqG5AoCAPkuceQ9wiXX2PgQv+C2mHglwV4Kku80xZDVCuLJFYd+MhtLTaYLTbqT0EhQOY9lyrVlrq/Kh7/gzgrR7cRasVhmadJBclWGwAiPcl6erxU6ybQdvXFRPaWQPibPyzk4KfrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxNdIa0G; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxNdIa0G"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8c0f15e8247so1328480285a.3
        for <rcu@vger.kernel.org>; Thu, 01 Jan 2026 00:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767257214; x=1767862014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+cCb3579Gv+EE/wlwP/51W7aCUJbUsslOfklq1uvNk=;
        b=CxNdIa0GMjpQkZ38BX2KPv9UOhzQ36p5RmW3r2hiO5QU6r51i9eNrzdz403Dhudj7k
         wRbrZk9umYL2pz+B3QZLDUL2E2z+sqTWnEWKgHTXp3pj9d90k0pVmvcDUziUd6iPjYBC
         /JBTVUiIDsQ6Jbw23+n60PA8bfkfkSU+UoIrQFY0TYMYIIhRH+O1PAnja2l46Bo/pIED
         37oAxbW8FZl+mMFLHsyRDrANZXZ03UOKOMtjWXnt49KmOKcFEyAdJPVFSnHqMeGJjyqE
         E9GYjvtuFNMn1mpFTb+BB9AyW3khn2kW8Q4BV2ME/SEgQaApOQM2nNS7xKLtHvwLL0xG
         AQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767257214; x=1767862014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9+cCb3579Gv+EE/wlwP/51W7aCUJbUsslOfklq1uvNk=;
        b=pgupKYPOBwxl3rpTjJWUeIXicJU6sN6o1t8nd1G8gUPY++sy6Oi9XNQGddZ5dAWr9o
         Y0JKjRU8gAI2SBiES6OmUMISAMcpET0wdDa9LAvRMrmXGL8zKrSLubPoI5gJqku9n+mP
         P69C1EfMUvJHcZXcgL42CCXQn8SUzpvXdy04aTHvZf3KHKey2HPfuvY+ZCXbCyIQpshD
         gu5e90oCY/W1ma1FwbO9nYvZzX6u6rFuA2kxqMZe+MW2FmxHvIh4BOdpwuX2Yg6qCBdr
         bLVE9W5akx6ON4vH2+0Ts228+OHD3Awn7uh/nLx3FxrViRAAKEqtMxfCw7z1bWBexrGa
         3epQ==
X-Gm-Message-State: AOJu0Yy1emsp6VZo7U7nnX9yK6W5C5AtHuTpyflqJ8dnZgWSuP46OWNl
	eUZXGs0tMtgDFUSeWfyhMS5ZRJcBPfKFsa1+TfPgCDpvqD+Ydoe4IF7L
X-Gm-Gg: AY/fxX4J5VotOR629GmiEbG8OtpV0OWE26OG2nr0VGtPi5DbF/O8JOMuXCeCkQEvjuO
	F5umTdXUEg8H/IwnwNmKxVnTKea9VBocFAdnfBCSdLz+kzjJKjMUoDMnGClpryOuT9Q+wWLOexw
	gmfzbG5e0R4z+RWzyfLB/G/I6wKUK8LxLqTZabiOH6l8XYlA5XGonZkWR0ZU/2n9u4pa9aoUkRH
	tqZTdNQBH/CwQVeVQdsE6/SGdMNLrHJnt36BpSmxQ0buZU3zQ5ewUKv+3hwh3RJMdoCgLJtowYn
	ltPziPGwwMaDVcmnguj+B5uhx6nnTB0Dl+gKd2vETcls8uyuDr08UB/u/85uovDRSYkYewMn87E
	eLchUBT0qze7dkd+NVJ2LY2UsxFGidfe6w3DB5GdDUDHVSm1UngI5MD49eik8ZWvpXCdO2LUN/n
	WZaaf01IMsqXiZn+wAiCFn6hkhc8OqvZ0QEk9lpO1LcU7/f+j3eO4UjLoxKe9fzKYx0xohndmH6
	8yPvFc8FGrKvrg=
X-Google-Smtp-Source: AGHT+IEGndAk7xQh6PiiYbjs+X9HMf9fdH4F+i9i1gyRK3R3jhKyCRF32dSpRMpStjfD4RdwaVYrjQ==
X-Received: by 2002:a05:620a:4484:b0:8bb:a037:fd8f with SMTP id af79cd13be357-8c08f340722mr5662557085a.0.1767257213933;
        Thu, 01 Jan 2026 00:46:53 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c096783922sm2980386885a.7.2026.01.01.00.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 00:46:53 -0800 (PST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 561E6F4006A;
	Thu,  1 Jan 2026 03:46:53 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 01 Jan 2026 03:46:53 -0500
X-ME-Sender: <xms:fTRWaTwN24SkK8PrhDUxvES7lAg0Et6p7U7H7zale3C_g9xuS9fD_g>
    <xme:fTRWaUn6ZX6wT1Az1pXes93hQwDee7KR5AxsXuUX7BvDnIinOiE-wQMdwW3CrYSqT
    f-WtYW62nTEAk8kmvqNzEyz92irt3C--Xh8s9dI7axgWhhvE8N_PQ>
X-ME-Received: <xmr:fTRWaUn2CuD0VNcmVcqHlzWK_lVCqrMf_TtZXSQ5pQU5zu8er0ibyx0_3jmc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekheeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrtghusehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesmh
    gvthgrrdgtohhmpdhrtghpthhtoheprhhoshhtvgguthesghhoohgumhhishdrohhrghdp
    rhgtphhtthhopegsohhquhhnsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:fTRWaeyRbCaoRXqdm__woeyBah3e_znNAoupwJqn_LC6Iy97ZyKzFQ>
    <xmx:fTRWaRqg7CKLS5BYhYbbcrnT78obzE4GbtpDxo7DRudSqivannjlCQ>
    <xmx:fTRWaV6LXZmTZNHoSkfsiltDe7P2TJAHUen-rxIeDJaNOHa1NNw5RQ>
    <xmx:fTRWaQen9kFvCIhpyFblzOmO-lHO7pUogM5GlqtWm3isr7vxbKB9Ag>
    <xmx:fTRWaS7WOEuV2yDpNBO7dnXS1D7-fS3GsVWsIozO-w1HAqGLWgSAYzkS>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Jan 2026 03:46:52 -0500 (EST)
Date: Thu, 1 Jan 2026 16:46:38 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH 0/6] Torture-test updates for post-v4.19
Message-ID: <aVY0btDoGY17otfc@tardis-2.local>
References: <eb69cddd-2e89-43a5-ba61-95af1d820dc0@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb69cddd-2e89-43a5-ba61-95af1d820dc0@paulmck-laptop>

On Mon, Dec 29, 2025 at 11:13:55AM -0800, Paul E. McKenney wrote:
> Hello!
> 
> These patches update the torture testing, most notably improving the
> performance of kvm-series.sh by a small but useful integer factor.
> 
> 1.	Add context checks to rcu_torture_timer().
> 
> 2.	Parallelize kvm-series.sh guest-OS execution.
> 
> 3.	Make kvm-series.sh give build numbers and totals.
> 
> 4.	Make kvm-series.sh give run numbers and totals.
> 
> 5.	Make config2csv.sh properly handle comments in .boot files.
> 
> 6.	Include commit discription in testid.txt.
> 
> 						Thanx, Paul
> 

Queued, thank you!

Regards,
Boqun

> ------------------------------------------------------------------------
> 
>  b/kernel/rcu/rcutorture.c                              |    3 
>  b/tools/testing/selftests/rcutorture/bin/config2csv.sh |    2 
>  b/tools/testing/selftests/rcutorture/bin/kvm-series.sh |  176 ++++++++++++++---
>  b/tools/testing/selftests/rcutorture/bin/mktestid.sh   |    2 
>  tools/testing/selftests/rcutorture/bin/kvm-series.sh   |   12 -
>  5 files changed, 169 insertions(+), 26 deletions(-)
> 
