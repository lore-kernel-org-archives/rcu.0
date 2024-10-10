Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9058EC153;
	Thu, 10 Oct 2024 08:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728548209; cv=none; b=r01IX+KTzivTb4TA/7b6LQErgHPNFlg3LKr+wUUTAW1WmDkNzcmV/MURTs/z2MuojGupHtrXlS+0IkZjc/AYFP05QKbep33CoQc74sj/6dQJ/GTtWNMBsa1vUVIsx4KGvJDW8UztzH3Esk4PuukA+V8TwYQi44jYvSalIcs2oN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728548209; c=relaxed/simple;
	bh=wFt66hRYuJmxRsyu0EYyqOHGyLlyWmtjJkTLei3olIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKqZhFsalSHXpnsuHMUhs9kkjbJ5IODYvhrnbDq3/fZTM98TxLwzpfY4SsRjG/QG2SeEm5O5NGR4zryTx+ez6EofcUqpw8visUncMx37CNx7UU40OdrDc1+AdLiWO9VlXhzux5T7OdxsRJAS1XJBdmeWAgg4acrmiopcxPc0dmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYjsIl6J; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYjsIl6J"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7afcf0625a9so67762585a.0;
        Thu, 10 Oct 2024 01:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728548206; x=1729153006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrRWTlMbh8H2NmoPMoUWJCWy0QREhDddrwTIMVfvwYQ=;
        b=XYjsIl6JLAamxPzKFPbi0+jUtw3/9yhS9rEDDJ1WCf7IN6qDB1eRaGyzG2O1O6tQ9C
         k0a1neCuaR5Z2DoK7QaAT60U2oL1orM2zpqMqLJp0ZRQVX3GlZ5spOTEgFc5ToexyR6J
         603Yr1jx1OvDlLkcCjzrq+mOrTQiDwAVb2pL/2kj4+Bp6lAgl0bI0BH1x+WE4cS2IolT
         Vse7jL7iGHHxEkTFiIgw0k3jeA2F8C8aviv2bGcwJR2KzufpiEHvCNP0S+1KcbvOZ+TV
         GYwL71seXSnE2yZJ+iWdwVXZSX8sSFstNH69T7gk+cU0fOky/mbOO5MG4tmRSwtPQXsH
         TlQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728548206; x=1729153006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrRWTlMbh8H2NmoPMoUWJCWy0QREhDddrwTIMVfvwYQ=;
        b=g5Gbqocm8kCOsucXz85iiwvo4dOiqu4DrojIfPptFgfkrdTFjLpnzvTjWvw1UAAXfq
         XC9+RrSrS9GP0GQyPrkR/Hj2WNvl5MV2ZNVyF5bD9WkmWKjoaPKK/SY9sj/WpX6i1XfX
         ffAw+yGeuuVeMdonSJ06pwmGuyCu38gkNZIcYlsQF10oviwS8hFA3xD1Gn/y+13FZMqN
         sjn966seKurRxpeT0t4w5Yg3y19Zzq/IJyf4nXC44k9MkjXhjtl/sZtO6MvsOs3m/GLP
         I/rHVOeHQWFz9Fk1VJ+ABj2NKNN0IpHv/joDbMT3LhE9suYqcl5RD+XlNuY1giYX/LXk
         t3og==
X-Forwarded-Encrypted: i=1; AJvYcCXJQgxCu1ygFUCmLX7yA0BVURgrnQkVU6UEkoySH8UfE/4gV9ZOcjfMJ9r6OryTJUU3YCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQr7MsQJPevmRo9ntQSA4EIVngysKzR4eItprTaocRnHIUg3DK
	g7H4fO79zlUP7RfQ0imAjojoTVUzLkgOOZLHia4VPJyIrU71nHNt
X-Google-Smtp-Source: AGHT+IHx/LJTzMQzg+IXsJzYsThqyeP0ui7eVONHumKV/hHC/685bnXccaTQTWL+WUQOTduBfD6tqw==
X-Received: by 2002:a05:620a:1925:b0:7b1:11f4:d0af with SMTP id af79cd13be357-7b111f4d196mr372869785a.29.1728548206416;
        Thu, 10 Oct 2024 01:16:46 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b114956001sm28673885a.72.2024.10.10.01.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 01:16:45 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 864D61200068;
	Thu, 10 Oct 2024 04:16:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 10 Oct 2024 04:16:45 -0400
X-ME-Sender: <xms:bY0HZ4dSVXIMCvLUqTbxJ3O-9Rw8we4ww5We01UhX7MxUyPJMnvg6g>
    <xme:bY0HZ6OJ48QLW7moncGOt8DZL9DY1z8Mt3ePUqJdhsPzLAQ7mlfwwoIEtdbrsYKNz
    PGAaM6pPMA8LPkJqQ>
X-ME-Received: <xmr:bY0HZ5hkLnZ7-t8IAiIUXM2ocNvrD4Eub-BLKoy3UsRLwmMxvYj9eh3uFsA8jA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefhedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeeitdefvefhteeklefgtefhgeelkeefffelvdev
    hfehueektdevhfettddvteevvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepledpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepfhhrvgguvghrihgtsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehjohgvlhesjhhovghlfhgvrhhnrghnuggvshdrohhrghdprhgtph
    htthhopehnvggvrhgrjhdruhhprgguhhihrgihsegrmhgurdgtohhmpdhrtghpthhtohep
    phgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuhhrvgiikhhisehgmh
    grihhlrdgtohhmpdhrtghpthhtohepqhhirghnghdriihhrghnghduvdduudesghhmrghi
    lhdrtghomhdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepsghoqhhunhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:bY0HZ9_QJNGf-jDkwRm8x2FR8jhGkFQQEIYR7fJ3Bbk8N0-KAoQ8Ew>
    <xmx:bY0HZ0sNLUyV6sibubeb01W0TATlgZUj-whzn-wtRzBmWgBgvz6wnw>
    <xmx:bY0HZ0GnKrXVBue2ApEls5ZsmOKqPzmzJ1DK9JPpPUqNgp7W2RSwEA>
    <xmx:bY0HZzMu93UtBnP0clyfD_MhYkh5hXFuRdDhTqMinXzJ01Jvq_5PGg>
    <xmx:bY0HZ5NKdScG2Q12r8QH01f7ol4vOxS-FIcW82NRM33y2MfuxaH2yxPF>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 04:16:45 -0400 (EDT)
Date: Thu, 10 Oct 2024 01:16:41 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 1/3] rcu/nocb: Use switch/case on NOCB timer state machine
Message-ID: <ZweNaSTMQOqXRIIN@boqun-archlinux>
References: <20241002145738.38226-1-frederic@kernel.org>
 <20241002145738.38226-2-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002145738.38226-2-frederic@kernel.org>

On Wed, Oct 02, 2024 at 04:57:36PM +0200, Frederic Weisbecker wrote:
> It's more convenient to benefit from the fallthrough feature of
> switch / case to handle the timer state machine. Also a new state is
> about to be added that will take advantage of it.
> 
> No intended functional change.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/rcu/tree_nocb.h | 33 +++++++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 97b99cd06923..2fb803f863da 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -271,22 +271,35 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
>  
>  	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
>  
> -	/*
> -	 * Bypass wakeup overrides previous deferments. In case of
> -	 * callback storms, no need to wake up too early.
> -	 */
> -	if (waketype == RCU_NOCB_WAKE_LAZY &&
> -	    rdp->nocb_defer_wakeup == RCU_NOCB_WAKE_NOT) {

In the old code, if this "if" branch is not taken,

> -		mod_timer(&rdp_gp->nocb_timer, jiffies + rcu_get_jiffies_lazy_flush());
> -		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
> -	} else if (waketype == RCU_NOCB_WAKE_BYPASS) {
> +	switch (waketype) {
> +	case RCU_NOCB_WAKE_BYPASS:
> +		/*
> +		 * Bypass wakeup overrides previous deferments. In case of
> +		 * callback storms, no need to wake up too early.
> +		 */
>  		mod_timer(&rdp_gp->nocb_timer, jiffies + 2);
>  		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
> -	} else {

... it will end up in this else branch, however,

> +		break;
> +	case RCU_NOCB_WAKE_LAZY:
> +		if (rdp->nocb_defer_wakeup == RCU_NOCB_WAKE_NOT) {
> +			mod_timer(&rdp_gp->nocb_timer, jiffies + rcu_get_jiffies_lazy_flush());
> +			WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
> +		}
> +		/*
> +		 * If the timer is already armed, a non-lazy enqueue may have happened
> +		 * in-between. Don't delay it and fall-through.
> +		 */
> +		break;

... here we break instead of fallthrough when waketype ==
RCU_NOCB_WAKE_LAZY and rdp->nocb_defer_wakeup != RCU_NOCB_WAKE_NOT, this
seems to me a functional change, is this intented?

Regards,
Boqun

> +	case RCU_NOCB_WAKE:
> +		fallthrough;
> +	case RCU_NOCB_WAKE_FORCE:
>  		if (rdp_gp->nocb_defer_wakeup < RCU_NOCB_WAKE)
>  			mod_timer(&rdp_gp->nocb_timer, jiffies + 1);
>  		if (rdp_gp->nocb_defer_wakeup < waketype)
>  			WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
>  	}
>  
>  	raw_spin_unlock_irqrestore(&rdp_gp->nocb_gp_lock, flags);
> -- 
> 2.46.0
> 
