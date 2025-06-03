Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2520817C224
	for <rcu@vger.kernel.org>; Tue,  3 Jun 2025 20:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748983497; cv=none; b=CglxDzUSvzMCYZVMYy9017s8Jqg3k5lBdjbQvLNPzLf2cnoJtqrJGqKoC2iTF3eVjMcaEUHIPqxTWwInvUeqRIvDTB29eJTtlSFysFw5dIOPbKVEKZ1MilZBPKrT93X9XGE95EPkb1fZuMnd4E/ellQI0WTXJ2JPnU/KV269iRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748983497; c=relaxed/simple;
	bh=lUyOHMVGls2KLBdZlsqweBZR6TNUlCvGkeJz5cS/Q0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJGEECOseRbZSAypcmP50MJIonu+pgKGsUaWTSfM1EQYiD5JZfXib8mURJxl2ox3AGPAekEwA7h9G5THVd8VzV4Gg69iSfv0HldV1AaGcx5eWccXRm3oqFbX3PoD+WBNImlRdntl2Y2qBCIkAEIAqzpaWl1PbCEN1IOfMKSDUzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbM42KHb; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbM42KHb"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a42cb03673so79489021cf.3
        for <rcu@vger.kernel.org>; Tue, 03 Jun 2025 13:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748983495; x=1749588295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SRxzTrI7wzKPPDMhKKisQdanzaslnU9eLGOPgJ9k+bU=;
        b=PbM42KHbpIQ5Mmpnte1Bx/U2jwuw1/0twgf8G/klq4lbi/nvhvGR8qcDzUyJ4BUVhU
         dy6lrjjIY60AtqzjHh3py4Ij+/vAaESZ6YjbR4Wn6175oS52xp7Tqe96zrtrzrCJtzF0
         625mq+zjB9IbsrqAR47GsRfmvP3mVuCQ5aA5dMikKjG/IiTvrHuIhSJRs25hNN3uh1gf
         2Rt7M2aLpU8+KlZwyeda3vG7pwv3RCD1DJwHzNJ50U/Hyfdb+QNMEsQ4FGiHgjJDCTHO
         mm8NZDYSfrsZ9LmSWHHRkzIeCnj8pPiiatRC6HGQX5I2zmxMsvzqgQn5WygC9+rEF7Fr
         LbLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748983495; x=1749588295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SRxzTrI7wzKPPDMhKKisQdanzaslnU9eLGOPgJ9k+bU=;
        b=OzNGY9MXEv8PzchDGXK3oTuOxwpAR1U7R3w/A1tjupvLyyrbs5qOGZXa+rbFJkf0gq
         ev7ymJ9Tft8pdPpLmNGiePEgrGqDZ8rQfLvarMuNICIaSlOJ3Wt+u7PIi4qPsNk1Imtd
         hcidZPmBA/YqKpvJJ75NyI4UFdPW6fK3s+MC9Bx1CwYuUVrAGBg0DcUwghuQbMCf7Mpl
         pgM5jTYJ7b3SMqzUP8kvDZOhBsjfMT7P+UYFqYKrz4bus7MXj0+Hw6ZhvTrMzvyplenw
         KbUIW3BdNYGFyAZyWe+4vkf/5XT3yrJNmn/95a6fetiKoDT1jde3SCFjGKsNJe0HCgYS
         mg+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW7ZD6p7rE30uRaJLPcCBPLGHgwEo7YGSLT9wMt3Lg0TTnfQN4b/lg5SpBvmLBoWTsS5CY=@vger.kernel.org
X-Gm-Message-State: AOJu0YykuYcsG6VVyBO70oSG9UWmiPkU3Dx6hgYV8k3CI51LkwLoMiY4
	xjE1Ca11pJSwevwxkoivCUJ9TOF0bahnUpHTESe/0TrhPSnitnJxGn6C
X-Gm-Gg: ASbGncs5Xoeyu1NztA34diPk6hWA5OKTv/XixZuae0p/gazn72NXk7X9b6OuQIlLkin
	W84TGcrYdeM1nkLyd60Y+LKzaG5e3FPs0qDIer5JWAHpQm429lAmGgsh1kISrbU/JDyWL5jluWj
	vjdsxwCaFRpXKXzvyS2L6Af5At0EFJnHJGVciUTyozTORzKOErjtdFnVQNjBZY4SV7EvEPcn5up
	bhlzdoC/CbGUho9ntDEohQXLEeDrOw4N79QF7RdX/FQX1nJq/w2et0gjuxAlHwi6OmZO4oZN7Ci
	x/cGgYhONGz8nCCuTNgCES6XOm6VDeBwA6qdCdi9YOwyyK4Z2+pVQV6avWH9pCUfk5fYuHli3qG
	m2EJsqW9xDAQa/BzfQVRSqzFq6/heKh0rrtpPrVEuuw==
X-Google-Smtp-Source: AGHT+IG/AleEp4XaU6dTuHGz+RinICY1/gGCJR8Q2keUe5GZCOiWIdWwjByNkzrc1qMqLhrzIPKA0g==
X-Received: by 2002:ac8:6f1a:0:b0:494:b1f9:d677 with SMTP id d75a77b69052e-4a5a584608amr4146511cf.48.1748983494598;
        Tue, 03 Jun 2025 13:44:54 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d09a112dc8sm899950585a.62.2025.06.03.13.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 13:44:54 -0700 (PDT)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id D29D1120006A;
	Tue,  3 Jun 2025 16:44:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 03 Jun 2025 16:44:53 -0400
X-ME-Sender: <xms:xV4_aGlAYBi3ltNGrKge4_xY3bZvxGxmjZdi5RSo-RAdDfH9voe_pQ>
    <xme:xV4_aN3em5G3rT5keiS--IOYDitNM4J_d7irDhGMwTwucMiAGIb-0hQOMFU7DYNMb
    bIucSgD6GBtwp7LUA>
X-ME-Received: <xmr:xV4_aErKtBqh2obCrTecpx5aKgaxRrBN6Z9mHHkBjt9XDV4asvMpt2gdRFE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteeh
    uddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehfrhgvuggvrhhitges
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvvghrrghjrdhiihhtrhdutdesghhmrg
    hilhdrtghomhdprhgtphhtthhopehurhgviihkihesghhmrghilhdrtghomhdprhgtphht
    thhopehjohgvlhgrghhnvghlfhesnhhvihguihgrrdgtohhmpdhrtghpthhtoheprhgtuh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsohhquhhnsehfihigmhgv
    rdhnrghmvg
X-ME-Proxy: <xmx:xV4_aKkJ1Lnx0S1uNligA7VmfT8Q0Y3Q-9EKl19W-0dRtue_Z_tuTw>
    <xmx:xV4_aE23BVLdLHHNWR37yXMKXkfPWqBVGdKc89ZNL694EtS7inqswg>
    <xmx:xV4_aBvWAFG_luj5DmNO1a9vBlB8KbRtRDjA1ViK0zRrVjsXWJzOsg>
    <xmx:xV4_aAX9OHuBgFOz20JkHkPTMdR9L4h7KXp_iOiutnGRl96zlu__Iw>
    <xmx:xV4_aP0F40n7SLPmnY9m3uG-DxVlGdPby9ZXmuhUak-G5deX5fA0zpzA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 16:44:53 -0400 (EDT)
Date: Tue, 3 Jun 2025 13:44:52 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	joelagnelf@nvidia.com, rcu@vger.kernel.org
Subject: Re: RCU patches in flight
Message-ID: <aD9exNsGkKng3ac5@tardis.local>
References: <b7a341ba-cd4d-468a-9d66-4aabe70a747d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7a341ba-cd4d-468a-9d66-4aabe70a747d@paulmck-laptop>

On Tue, Jun 03, 2025 at 01:01:19PM -0700, Paul E. McKenney wrote:
> Hello!
> 
> From what I can see, when I start testing v6.16-rc1, I will need to pull
> in the following commits and patches into my pile in my -rcu "dev" branch:
> 
> 6c59a7c789f0 ("rcutorture: Add tests for SRCU up/down reader primitives")
> 0a67dd132d1d ("rcutorture: Pull rcu_torture_updown() loop body into new function")
> c27d0d38f2ca ("rcutorture: Complain if an ->up_read() is delayed more than 10 seconds")
> 3b4863a42139 ("rcutorture: Check for ->up_read() without matching ->down_read()")
> 
> The above commits must be ordered after this -rcu "dev" commit:
> 
> db950fccd45a ("rcutorture: Make rcutorture_one_extend_check() account for hardirq")
> 	Tested-by: kernel test robot <oliver.sang@intel.com>
> 
> There might be a few conflicts to resolve.  ;-)
> 
> I need to drop the following commits because they are already in mainline
> (thank you, Joel!):
> 
> 604d70035eaf ("torture: Check for "Call trace:" as well as "Call Trace:")
> 2e5158390089 ("rcutorture: Reduce TREE01 CPU overcommit")
> 90c0254a6d48 ("rcutorture: Remove MAXSMP and CPUMASK_OFFSTACK from TREE01")
> 
> Anything else?
> 

Hmm... we didn't sync Joel's rcu/dev to the rcu repo, did we? I believe
Joel had a few patches queued in the rcu/dev of his repo:

	https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git rcu/dev

, which should be handed over to the next guy.

These are the commmits:

ac05b397cb2b ("rcutorture: Start rcu_torture_writer() after rcu_torture_reader()")
006bc5216bd0 ("rcutorture: Print only one rtort_pipe_count splat")
af97b7685824 ("rcutorture: Check for no up/down readers at task level")
2baf873c6c2b ("torture: Suppress torture.sh "Zero time" messages for disabled tests")
b0fb3ada8fb0 ("rcu: Robustify rcu_is_cpu_rrupt_from_idle()")
e2cf1ccc99a3 ("rcu/exp: Warn on CPU lagging for too long within hotplug IPI's blindspot")
e8b1ec78cf81 ("rcu/exp: Warn on QS requested on dying CPU")
b4783fc5ab1f ("rcu/exp: Remove needless CPU up quiescent state report")
a7e008d32033 ("rcu/exp: Remove confusing needless full barrier on task unblock")
6e8a70ce57b6 ("rcu/exp: Protect against early QS report")

@Joel, do you want me to sync this rcu/dev branch to the rcu repo then?

Regards,
Boqun
> 							Thanx, Paul
