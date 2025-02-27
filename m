Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDCC136351;
	Thu, 27 Feb 2025 17:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740677417; cv=none; b=Au/Mprsg/rvA34RnaMBJXOUTYPjnRN0dct/GL26inpzBisympmhtFwe9471ci828R23jDRpPhifsHMCLm145YdEX52hkt7EIQshNRVc6DAId5X+v89BA8oZsKPFy1nbwG4MoswTy4k8F7V2Ka2VBM4ZL/pkKfs7ZNaIieqyHm/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740677417; c=relaxed/simple;
	bh=BHOmUMRksJWGkPGQguX9AGezCQ1EireXEQhlLKUOn+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUgtLseOqB3MVaUIHMyKJwMvNWyoC47CrsXnqIiZPImCCNcMw7RE17DvCcJCOwVjmQYnoDWJ02mUKOyLYRorZ7KzKMaf019+HCaJPxT2bAnNvbXy/Ru8KeAdNf4BT4UKcx6Un1RjLpv5zUwvkG8e1Wl6sWqCp1KN/oIU/AzoChA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WF5hv/jj; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WF5hv/jj"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c07cd527e4so111682285a.3;
        Thu, 27 Feb 2025 09:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740677413; x=1741282213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ncAr0i2yaCNPOat1iqqfGrGLU6UJ1TbQz5tFfMPH0g=;
        b=WF5hv/jjMLiVzAPId0v2EOLpwfTh19vdQcTYZhloWx5dNK2k270bOmZAq5As4hJ1A9
         mNAwbyjC0zsu23cQSuOlw38JT+IuqgUOj57kdmfwlIL8xrEbGOqbdGkhuiP76QFnsWjk
         d0NwgAhQn1cma6x49cOvXonm71TreBbz06vGcvMPUzCpCA4wuNI+QwhPHMlfFPeIVlTQ
         h2AKe0DM7CbMa9+TuIMWlF7AWGiDoxXInDnjl4le+nSLaF9oLadxSigMuuAAtNovtV9/
         QnWEwqEeuzFfj3ob1Jf5Y0WINRKEQNBs33cz3aLHhEydrLyXTxSkO9wrvChdUUTWxb3Q
         NHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740677413; x=1741282213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ncAr0i2yaCNPOat1iqqfGrGLU6UJ1TbQz5tFfMPH0g=;
        b=G8EzVmdu1CcK8LbSiPV+YoDdCAWib17IKa16lLZpPXqSnWm/eLzMUwaLnySJvvDteV
         RZmW1bOBHIacZ+BT+fOEul9/CqYvleYeb/LH+WCRjva6HjInq6hQusfQovuA+wwSmB3v
         lFGZtT9hg2RnD8vPVeEbo90vZauTXFBYGj0L9ny/fuwgLMIrAoou5RqydQyAVrzELdN8
         RffcYQjMCW+cPJPTzIbiLMCrX9IDqCT3FXNkAAZZKYdDUOkIh5hYpe5q+0GgnlxxG3xF
         gTkqxtM/mdTxHcycEDvpx0JB2RZSaqc9gN3UnJ+yUhW5gqCMr/ROpu5WSLdwABp5wyhG
         vwlw==
X-Forwarded-Encrypted: i=1; AJvYcCWwaosvoQHSzQuXvka/GgTN9jqDsBpde7YdhiOpxpIuhKuRb5J+to3zz5f212hh2wDi5TgK@vger.kernel.org, AJvYcCXNePfDhAikQhicvM5vgwW3n+E0MBC/glcb7VlNih3nrkfQCo7Jvl2jUWK+XuSGYozc6DavJc1OSv0bdv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbEzt/rWDURhIkTP7QPtS5RuIc629Cvcip5zrYu1taw66JKm4U
	BOKS52Zhx61OuKkaBPU+neirAte+m0/igGMAu1Xuf4HKns5s0QS+
X-Gm-Gg: ASbGnctj6pHPsiuQqPnZbtCuXMGADA4t6hoXtTXFwTErvmVGT4EwVxPOmLzepUfkyyz
	GtlTeCMtli3xtjw6k10YJ7PV2hIKiii+O8YDi0HwgBg61XZexkWXzNhqMsxDc+RcD89Bxvxt/TF
	S0JqgU/GD03qA1J9CXH63j7NlelUnZK+dStgN1ZpRRjMm2k+OQDDO1FdSLrbBh5R+L3F/xBxO8N
	gxScoEjhL3KUTXdJarBH10GyWgS4g3lsY6SpH/x63HseOn1i44JdBP5We5nevzQubbHksZvmrBi
	EVHKk3DYr0YAed0qIt8rUhNN8uwyLL9JLUnOiB73qbbKZl3a4YvwW9ScudaYUY2JKwFxBTQJEit
	ASKpovM0zik3LBuU9
X-Google-Smtp-Source: AGHT+IEhqRePoIEaEEW0l4JynfwuD/1O+VvhzuB6mR89VzP+NE6CE3gvCV8+gHkU6kXrYKP0OaNTog==
X-Received: by 2002:a05:6214:2462:b0:6e4:4331:aae6 with SMTP id 6a1803df08f44-6e8a0d9990emr3818696d6.39.1740677413129;
        Thu, 27 Feb 2025 09:30:13 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c378dacd0bsm128276585a.90.2025.02.27.09.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 09:30:12 -0800 (PST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3E6351200068;
	Thu, 27 Feb 2025 12:30:12 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 27 Feb 2025 12:30:12 -0500
X-ME-Sender: <xms:JKHAZ-D0TIFIsKsJPPCWSFad9tofZ9djQnjg67vN3Z7CcuW6x6S8Ig>
    <xme:JKHAZ4ifO3jbwhr-io6oJzVOOtho4VzmiTVkrVxy4nvQss1syz5qsulBRYhZqyJTw
    ZDtwUW3KWcvYzeCvg>
X-ME-Received: <xmr:JKHAZxl1d7sr072cfyNBRS8Y95Rm5Be3dLmnRnqiEI7F6fQfRAJD92wNUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekkedtjecutefuodetggdotefrod
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
    hopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehurhgviihkihes
    ghhmrghilhdrtghomhdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepfhhrvgguvghrihgtsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopeiiiihqqhdtuddtfedrhhgvhiesghhmrghilhdrtghomhdprhgtphhtthhopehnvggv
    rhgrjhdruhhprgguhhihrgihsegrmhgurdgtohhmpdhrtghpthhtohepjhhovghlsehjoh
    gvlhhfvghrnhgrnhguvghsrdhorhhgpdhrtghpthhtohepohhlvghkshhihidrrghvrhgr
    mhgthhgvnhhkohesshhonhihrdgtohhm
X-ME-Proxy: <xmx:JKHAZ8y9AAvkHojA27_cBk5BWAj8hl7oYAGTCuMBHgK1-n3UipUAKg>
    <xmx:JKHAZzTcKXacDepN72FnnqrB3BWoCg4uQrrNJvuDRoZzbWI2RQCVvQ>
    <xmx:JKHAZ3YWgIQVCMxEP00WZ5oDY0ZGOIEr0hYIIdKtqHKBNcre0TE3ww>
    <xmx:JKHAZ8QlHfrCEJwTe05Fa4cjbU5lIUeSDJ0l3AxZfA-CN0-xM5ms0Q>
    <xmx:JKHAZ1D5t3_2zfre3BSSmRRoBqxccp1hH-SpYWbRbvAGZ6ymkQAltClY>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 12:30:11 -0500 (EST)
Date: Thu, 27 Feb 2025 09:30:10 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v4 3/3] rcu: Use _full() API to debug synchronize_rcu()
Message-ID: <Z8ChIpP7pcq-1-Qz@Mac.home>
References: <20250227131613.52683-1-urezki@gmail.com>
 <20250227131613.52683-3-urezki@gmail.com>
 <Z8CdB0Hzvdu5ZVSI@Mac.home>
 <d8b196c1-c1b5-4bf9-b1cb-dde8642cc34b@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8b196c1-c1b5-4bf9-b1cb-dde8642cc34b@paulmck-laptop>

On Thu, Feb 27, 2025 at 09:26:40AM -0800, Paul E. McKenney wrote:
> On Thu, Feb 27, 2025 at 09:12:39AM -0800, Boqun Feng wrote:
> > Hi Ulad,
> > 
> > I put these three patches into next (and misc.2025.02.27a) for some
> > testing, hopefully it all goes well and they can make it v6.15.
> > 
> > A few tag changed below:
> > 
> > On Thu, Feb 27, 2025 at 02:16:13PM +0100, Uladzislau Rezki (Sony) wrote:
> > > Switch for using of get_state_synchronize_rcu_full() and
> > > poll_state_synchronize_rcu_full() pair to debug a normal
> > > synchronize_rcu() call.
> > > 
> > > Just using "not" full APIs to identify if a grace period is
> > > passed or not might lead to a false-positive kernel splat.
> > > 
> > > It can happen, because get_state_synchronize_rcu() compresses
> > > both normal and expedited states into one single unsigned long
> > > value, so a poll_state_synchronize_rcu() can miss GP-completion
> > > when synchronize_rcu()/synchronize_rcu_expedited() concurrently
> > > run.
> > > 
> > > To address this, switch to poll_state_synchronize_rcu_full() and
> > > get_state_synchronize_rcu_full() APIs, which use separate variables
> > > for expedited and normal states.
> > > 
> > > Link: https://lore.kernel.org/lkml/Z5ikQeVmVdsWQrdD@pc636/T/
> > 
> > I switch this into "Closes:" per checkpatch.
> > 
> > > Fixes: 988f569ae041 ("rcu: Reduce synchronize_rcu() latency")
> > > Reported-by: cheung wall <zzqq0103.hey@gmail.com>
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > 
> > You seem to forget add Paul's Reviewed-by, so I add it in rcu/next.
> > Would you or Paul double-check the Reviewed-by should be here?
> 
> I am good with keeping my Reviewed-by tags.
> 

Thank you!

Regards,
Boqun

> 							Thanx, Paul
> 
[...]
