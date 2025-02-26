Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0990A21D5AE;
	Wed, 26 Feb 2025 18:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740596314; cv=none; b=gGeL/OIOCtmXNW/nRPDksfspOIcDaDlWzwd/37w3N0r0e0RwE8+7gzq0Ae6y+2BHPumNnD1BYHmJXpvljf693uMIlMCHHwlT0I/QCAHyHpTie7Yvsd5SKo9c3yRiEkuz2ytr/Et/Y3rbOG66sCW3G2zohLOFaMdIBoSGUYQGNqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740596314; c=relaxed/simple;
	bh=Ixv0aUbuMViMkee7CitjT5g4MBDEfUW4rCdAyzc0Im4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmdekxFusJF7RmvZKI4wnBfa1Q93PLLku8IIw3ZQksUU0ESYcpxn6HBBxG8H9swBNQRZMDyWeVB1o9y2tKKlvbHCWag+tK1mRjXh+cLaF1RQ3P08yJMvZRC5gTXhftERBubeRqRrPtFg4ylxUnoKDmomqt2bSuOW3fejpxY6lxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IrNMbnzg; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrNMbnzg"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-472087177a5so1318161cf.2;
        Wed, 26 Feb 2025 10:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740596312; x=1741201112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2op1a0SbBWvh0Hl6r6gog+2Bmgqf7W6TwOT7frF88A=;
        b=IrNMbnzgLItO2XU548vyfu05ZqSVRt4prQbDl0jkeoTdF9MI11c2L+I4Af4VEKtYr3
         XSutHwzHeX4RWHfOWfNlX2vqTeyM5aXiS93FCC+nJa4gv/TMeAPGYgNjaRSUJoRGog5u
         PxeGm2dYkLyceQwi9e6iLsVQASIbqhkaJ2/+4yzmpmKjYfNxOW6eGgJHhEoilLydwIC1
         gAVYzC7NAElhrHnOsm6kdghPIJlP/xogW5axYw5vO0MnTxbRX3YxXDISNWgWjR2mWwRJ
         SLsRVtkBQKNb9C3ufuDu76cA2FZ/ClXRngoscwlqBoxELiUK4ootUjfXdy/E7J8qMKuD
         2Urw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740596312; x=1741201112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2op1a0SbBWvh0Hl6r6gog+2Bmgqf7W6TwOT7frF88A=;
        b=p91W6dbaymdyo8SGVWYxlrS7NPPOdDNRzLHld605SUHO58J8+u68SShie5WOxBK8sp
         L2AenEmGobGZrbmmY507x5yxDthT59un/521gHg6UGu066Ww2zEEEYnE9kFRRAHPHZcR
         rAnISvXOmJ41sFWjlv5pzZiHvi1LDZ7UbVnnYU9J1EKaRamBTBoiNaxobml/FQ0iZ03g
         9eov59R/ueMWUvpZr7el8mxyz4lFj5jmFFWYBOSt8Yd648zW4od2je9psapc4IyvpcLY
         sPnJcrU04/FOFlA+q6X3JrnKHd/tdaodNyAENfo846WK+sQmXCN/3bp+05el/f9ih3RP
         6QuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUPY2XJjNGDVDp9UwgoXR2RNMzKoPU7+WeAdiLfOoEzP7qjQdUSqkaJv1rcLiegT6jFUKQmwcGNUKHJ4k=@vger.kernel.org, AJvYcCVxFubgR3wSVDnqL4wZIXg0yo3NSNdJhhDn19hr+IE5Vm29WWk8Bthv+7WmmLZ63QsOl9Ak@vger.kernel.org
X-Gm-Message-State: AOJu0Yws69B/lHO5AXX0M/IOD4XhxEzEuborUOx7+z+44oXrBkyQbCg6
	/6ctq3Jn3JLTyQp4LNMPzgFkb4F4VhCW2ru9LGMLOhJpzVuNC6GtSdKiQQ==
X-Gm-Gg: ASbGncsefljpUPt1yGmpOu7h1GtcnXiTvxsKgzBu7eLbuyMwPZLCnEt48ktns5Zl1tY
	DeIxfOO6ad4q4N7Hy9xVcNBf7OnoyEzFl421RJjcRl8z++h+Yl3boMWOmUO2Uy6R6npor6tDPNg
	mqhwXbPeGL+rRDYrNXOQXsZPeAZgJ1dFeOqh1WpJiw1QsckPKSAAoH1o21Cq8rA0B6GF2fsYQbO
	xbR477AkXiTq+KJECwSsZUpLh2cndhvjAcvw8oeA3TilEU6Lh6OzsdPYyCENxUrzXOiQJhUc6Px
	p7i5rQBPELlVL3W8VyQE2XCw4+seCg9jVSlrFN/elb9qdmLOnyoInNJ9X0eO3m3Y6+37rvPhdrU
	Q6oW4gRLVdUhsUGIg
X-Google-Smtp-Source: AGHT+IHWFEdXUpbnHQFZ48tCEhh1mWRdxOE8u8nF/86nEldpaJXKeLhIbg8ZQXIsFUwicUcyv0TApA==
X-Received: by 2002:ac8:45c7:0:b0:473:8c05:2b5b with SMTP id d75a77b69052e-4738c053527mr15965071cf.47.1740596311766;
        Wed, 26 Feb 2025 10:58:31 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4737806a53csm27942711cf.57.2025.02.26.10.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 10:58:31 -0800 (PST)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id DB8621200068;
	Wed, 26 Feb 2025 13:58:30 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 26 Feb 2025 13:58:30 -0500
X-ME-Sender: <xms:VmS_Z821Y05UbTOv9o7MghzOv5y1rshqaYWgDKpM4tVlggDmXPmHPA>
    <xme:VmS_Z3GyvJx5bApebjuWT_Nuf1z8mFwOIFNDK3B6HovQN7ziZTmpH6zckEph67NQJ
    LId1HRx-SLRp-Be3g>
X-ME-Received: <xmr:VmS_Z07YNbqx4fbr3LfLcYBxMOF_vJquxWlnf6fVerym1bcENtY0_7PPYRE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekheefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephfetvdfgtdeukedvkeeiteeiteejieehvdet
    heduudejvdektdekfeegvddvhedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvgdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehurhgviihkihesghhmrghilhdrtghomhdprhgtphhtthhopehprghulhhmtghksehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepfhhrvgguvghrihgtsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopeiiiihqqhdtuddtfedrhhgvhiesghhmrghilhdrtghomhdprhgtphhtthhopehnvggv
    rhgrjhdruhhprgguhhihrgihsegrmhgurdgtohhmpdhrtghpthhtohepjhhovghlsehjoh
    gvlhhfvghrnhgrnhguvghsrdhorhhgpdhrtghpthhtohepohhlvghkshhihidrrghvrhgr
    mhgthhgvnhhkohesshhonhihrdgtohhm
X-ME-Proxy: <xmx:VmS_Z12ZDvrh9vx-UqTf_l3iy1o-eLyGUbx1IHhmq_R0Zpmm9r6Ejg>
    <xmx:VmS_Z_GeANo7X4Zov6n45tIwMSRlOfb9d_8e7MH_1H-pDB138JrOCw>
    <xmx:VmS_Z-_OImZwGl3lCJ6lY3RwmOtlVuy3RYaAOwzrqqis8i5IQESlwQ>
    <xmx:VmS_Z0lnrjusOUMTlP1LLpW9HqRKptWnwL0IsghB3yzbYZ_GICfuYg>
    <xmx:VmS_Z_FcCqjnU3dRM2VU-tYWDVWvbkNMV4dLi1LWfbOfqfeY4V-M2cUf>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 13:58:30 -0500 (EST)
Date: Wed, 26 Feb 2025 10:57:46 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v3 3/3] rcu: Use _full() API to debug synchronize_rcu()
Message-ID: <Z79kKiokpq9FpjYc@boqun-archlinux>
References: <20250225110020.59221-1-urezki@gmail.com>
 <20250225110020.59221-3-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225110020.59221-3-urezki@gmail.com>

Hi Ulad,

On Tue, Feb 25, 2025 at 12:00:20PM +0100, Uladzislau Rezki (Sony) wrote:
> Switch for using of get_state_synchronize_rcu_full() and
> poll_state_synchronize_rcu_full() pair for debug a normal
> synchronize_rcu() call.
> 
> Just using "not" full APIs to identify if a grace period
> is passed or not might lead to a false kernel splat.
> 

Could you provide detailed explanation on this? I.e. why is _full() is
needed? I find the current commit message is a bit vague.

Regards,
Boqun

> Link: https://lore.kernel.org/lkml/Z5ikQeVmVdsWQrdD@pc636/T/
> Fixes: 988f569ae041 ("rcu: Reduce synchronize_rcu() latency")
> Reported-by: cheung wall <zzqq0103.hey@gmail.com>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  include/linux/rcupdate_wait.h | 3 +++
>  kernel/rcu/tree.c             | 8 +++-----
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/rcupdate_wait.h b/include/linux/rcupdate_wait.h
> index f9bed3d3f78d..4c92d4291cce 100644
> --- a/include/linux/rcupdate_wait.h
> +++ b/include/linux/rcupdate_wait.h
> @@ -16,6 +16,9 @@
>  struct rcu_synchronize {
>  	struct rcu_head head;
>  	struct completion completion;
> +
> +	/* This is for debugging. */
> +	struct rcu_gp_oldstate oldstate;
>  };
>  void wakeme_after_rcu(struct rcu_head *head);
>  
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 8625f616c65a..48384fa2eaeb 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1632,12 +1632,10 @@ static void rcu_sr_normal_complete(struct llist_node *node)
>  {
>  	struct rcu_synchronize *rs = container_of(
>  		(struct rcu_head *) node, struct rcu_synchronize, head);
> -	unsigned long oldstate = (unsigned long) rs->head.func;
>  
>  	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) &&
> -		!poll_state_synchronize_rcu(oldstate),
> -		"A full grace period is not passed yet: %lu",
> -		rcu_seq_diff(get_state_synchronize_rcu(), oldstate));
> +		!poll_state_synchronize_rcu_full(&rs->oldstate),
> +		"A full grace period is not passed yet!\n");
>  
>  	/* Finally. */
>  	complete(&rs->completion);
> @@ -3247,7 +3245,7 @@ static void synchronize_rcu_normal(void)
>  	 * snapshot before adding a request.
>  	 */
>  	if (IS_ENABLED(CONFIG_PROVE_RCU))
> -		rs.head.func = (void *) get_state_synchronize_rcu();
> +		get_state_synchronize_rcu_full(&rs.oldstate);
>  
>  	rcu_sr_normal_add_req(&rs);
>  
> -- 
> 2.39.5
> 
