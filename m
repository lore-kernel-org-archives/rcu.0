Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D263E1D4335;
	Thu, 27 Feb 2025 17:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740676366; cv=none; b=b7ZPxyj8/GCxpPK7g2kfJqmFLl+oJffV+7noTwNAdFvLo49HRrFkQCaZJSphOKTZ3t0h+milhc4wePoVFjPy+DrQPnXZQpRp7PKIyoYEWNVtJZWMIz0RThnTVQChdi40LDVt45RBdBdKUlM3gSEmX/XX/bnwWwO/ZoVTVN+PHAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740676366; c=relaxed/simple;
	bh=HK2KY7PiRij07GlAmhhH2ynVAYCKJ274hOV7GNM8waE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLz2Gf2LoaC8za6bkN7mAfrgCknQYl2Wxs5rQaw/Dfyu13OyWDiLrgJ5Y/1AeY5Eo23yOcZoVj83DqQRHAOD8Nn6ZkIDcdDsOCpkolr+GxQlsNt8aT/gisUOu1lKXmiHu+5CHuEJBxAtt+HgR3bNY5SpTpZvS4tesF/eiqebbJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0F2uYWs; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0F2uYWs"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-47208e35f9cso13918301cf.3;
        Thu, 27 Feb 2025 09:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740676363; x=1741281163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rzu8L0tKuIvHSkCL8EOFMmJLvXatvVxOlxEr3+xc7vE=;
        b=O0F2uYWsTLESxHKVa5c+uLhaCqe6goEiI4o7YloyRnR+goVtQud6Gg75GpkekIdkb3
         fwVSmoTK5BFc3Q4FhWKdRcm/oOKWvdJ0di7DeXPRSswe6EhITlVh50VK9xd9wpgrYkXw
         ohOMLkNo0vmd4koGcxBKQq98O749JmLmgnVwy5sXxC9zd71r0ucra0F16pS3K0gZKsNe
         nh2bkTLwsU5kz5ImJB7uDVIwKSqDOmsNcuDKYhAELI+oho5bd0RTgw77oC2HPIAhmmk7
         ahPkmIvgCRcnWbjw95c3OkyhQRY7iibgun7mq23DnKh4CUwU0sGqrMff3NYnSqboRT4j
         Usjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740676363; x=1741281163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rzu8L0tKuIvHSkCL8EOFMmJLvXatvVxOlxEr3+xc7vE=;
        b=NWL5ksNE0L3wg86cE4bpqJfOqfCuiGCD50GhB2Yxqid3zo7hJMVfTMTTwCjuiPMZ40
         V6AIaH7A/gh4tDyo1ITK+IFnbNHZPbvQT4HMkz3acjDnhFrEQGdvwHfqQZeaHj0V1a+4
         JSDANwZ5vZWW7hBIuOUpLRA4MRlLzp/XNKupEyXpL92KpQ2sGlURux5JNTwtSOeI4b1n
         o/AXZ1FpCONRAxh7Tjdyb8sX/cQ0gtyxcoI8PGTZYcdcJK1be5Bwmhlbd7he7GrT4qo0
         ZxcbMsP11X7W4MoLZq434gZ8fbOKU9fAgplgrln7hoxA/w+tuEbq5TzVlNOdkZoWxXpM
         ittQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9k/FYlS+NXIVFYzo79dVNV6NbS+YN1wdoWYDOqdvl6Ft/rhcXnNXOwREsYB/DA+QAluKz@vger.kernel.org, AJvYcCVzqbErkZsw2GsJvN/Q2WxeU90Zp2YDx7XbLlPOC2l06veVvAiI0cZJZ6u2XDVnCNl4RWaOsQ6DaAifs+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBR8deVgiUUm7TsKE4MTO7aac/4OhQ8s1kfcnoqrPE9yKrozuj
	2tLkQJn/D7ulwB0kB7SElWOQW4ZCl3Hp7JVtaNnoAMUngSEOu2PrlwCoJg==
X-Gm-Gg: ASbGncv29UliwE1eToRbIGN3ZMK93E1yyQ6iGSu9LvimcVuJtXD0Zq0w2hINmU1OLAA
	J7qhx6B2J8Ld80a0mJGDZlyypiPbNNryB6S5IfqrZnGCZarTYRr1si8HaYF8f2Xx25G/1Je0+wF
	uZdhTQTXuKnAOrRxfsJlLHGz4WxFIoSwyIHVM13zOZmIflDZdh39pGmiv1uD8NsaX/SATUsU752
	iAe0FJFV2DDhOB96PzikXf/MeTtmR51ZBjdzFEYfWAQ8MYZWUaeIXEbzuzvi696mwEcaMSKYKl4
	6aF1Ho/lfaXhFKRVjZaFoLdvbDP8sn7SyHjRiDoVTgZTESjdWKAjAXB5fvO47iyamRH3psBwQ3I
	nwM0DtaNnbC1Z7p0B
X-Google-Smtp-Source: AGHT+IG1vu20wLowraN1Sfjlep2uRM62hIpnaVhVjh6Tr3CleRTEmwp3Q+ytrM5BVIbRkBnYTsSW4A==
X-Received: by 2002:ac8:5a8e:0:b0:471:c78d:8d84 with SMTP id d75a77b69052e-47381375d2cmr131597071cf.43.1740676362632;
        Thu, 27 Feb 2025 09:12:42 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47472409b48sm13029961cf.64.2025.02.27.09.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 09:12:41 -0800 (PST)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 069F41200066;
	Thu, 27 Feb 2025 12:12:41 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 27 Feb 2025 12:12:41 -0500
X-ME-Sender: <xms:CJ3AZ8kMGRIcYgMiOV-PYWRhz0_eUEQsf916XZm15NzRQUbPt38ALw>
    <xme:CJ3AZ70jaZUMNUCfd-N7XCcW5dc394Eaea493fG07olYW2BYBMT12A_I8RHjCp6u3
    Tty9zYV--NFfprtuA>
X-ME-Received: <xmr:CJ3AZ6pdfOPTNO2fz6gcKuGER44k1WLeEMfc8NiD6k0Bjc6X_uT_OdhQUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekkedtvdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:CJ3AZ4kJtqHpBJ-TRdbm772bR3upglslXp_hOvqsUuVzW8yJeC5s_A>
    <xmx:CJ3AZ63pojsHG4AjujD1pcFxZ1-btw7FBZw2pJu4_m1lQ5XdMNltxQ>
    <xmx:CJ3AZ_uIsbRdHSB3rlqOwfbB1ZKvGFtjvvSQ_Np3vTo8RWquI8_U5A>
    <xmx:CJ3AZ2VmqtTRGH3z1A9rq-b3BEl4bqM41OSkzE9Mu2wtzS3_Ltf0Bw>
    <xmx:CJ3AZ90jWaiqjK4dyc0OuXs06cHc8bMYESX5bZjQkMLDq-7Mv-sP6eD_>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 12:12:40 -0500 (EST)
Date: Thu, 27 Feb 2025 09:12:39 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v4 3/3] rcu: Use _full() API to debug synchronize_rcu()
Message-ID: <Z8CdB0Hzvdu5ZVSI@Mac.home>
References: <20250227131613.52683-1-urezki@gmail.com>
 <20250227131613.52683-3-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227131613.52683-3-urezki@gmail.com>

Hi Ulad,

I put these three patches into next (and misc.2025.02.27a) for some
testing, hopefully it all goes well and they can make it v6.15.

A few tag changed below:

On Thu, Feb 27, 2025 at 02:16:13PM +0100, Uladzislau Rezki (Sony) wrote:
> Switch for using of get_state_synchronize_rcu_full() and
> poll_state_synchronize_rcu_full() pair to debug a normal
> synchronize_rcu() call.
> 
> Just using "not" full APIs to identify if a grace period is
> passed or not might lead to a false-positive kernel splat.
> 
> It can happen, because get_state_synchronize_rcu() compresses
> both normal and expedited states into one single unsigned long
> value, so a poll_state_synchronize_rcu() can miss GP-completion
> when synchronize_rcu()/synchronize_rcu_expedited() concurrently
> run.
> 
> To address this, switch to poll_state_synchronize_rcu_full() and
> get_state_synchronize_rcu_full() APIs, which use separate variables
> for expedited and normal states.
> 
> Link: https://lore.kernel.org/lkml/Z5ikQeVmVdsWQrdD@pc636/T/

I switch this into "Closes:" per checkpatch.

> Fixes: 988f569ae041 ("rcu: Reduce synchronize_rcu() latency")
> Reported-by: cheung wall <zzqq0103.hey@gmail.com>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

You seem to forget add Paul's Reviewed-by, so I add it in rcu/next.
Would you or Paul double-check the Reviewed-by should be here?

Regards,
Boqun

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
