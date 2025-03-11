Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584E32566CE;
	Tue, 11 Mar 2025 12:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696740; cv=none; b=uvEfjK4LwlB4WOpCQOVVgHnNataWswfYkkMeaqec7AeiA8bM14HX69CEdsAqcOO8BYmi5OO/oRdkFbv8HVXCVGbxfNpd3XHv8JF+RQKHw7oxyCVWTDGFpK3zOAOu964hONUqnjTi50NT8x268xTFVQTzqdmlzNyBMD6iT8MFzvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696740; c=relaxed/simple;
	bh=cltyPHCJ49JbabS3P+aS/KZW4H/0eZzPUIxutqhJIwg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgHi30ttKPvt/4bbd0nXdk7jXoVj2pcwjvafUeoM0W92gVt2Et0n0djjCeIrNETgXTU3d8oWHPUprlfRE4xp27JPxFZT630qzQwynXdJ0/ZPbb1OJHTISqp89WPSJL3catUbiap3ou8/RG7b/j1PNerOT+gRqxNvaNi7v9ngTEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CszX6Zmy; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CszX6Zmy"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30615661f98so58142581fa.2;
        Tue, 11 Mar 2025 05:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741696736; x=1742301536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Zq92IivDzfgLqOwKYZMD/CP0Rg3YY3KQafzGl2ujB8=;
        b=CszX6Zmyk7Sz7RVBt0E7akXCsdWukQ152DSfuq2RRCFsRLbsZ2Ko25jzcnLLdhDbD3
         MbUQVomHymk1t6sZmY0WOMqX8b4ha3g9YbVfY61gZmzczMddAwfEuA+W2BYzuimggKt1
         ru5lnqhG0vC9silFIqbMKmDbW/0YckaBAc2qmBBul98D5tdLozvbu8ws4mUUaZHwHXfm
         uo249yTmCiAu0w4c3zGgjaMr9QYbigAgIeJxAC+5EHOl1EoVbaRcxg/DfdLAeMUZ+cIP
         QoNhFyPJgd5vOkpL0DgqZPEhYFoU+/g9JLDsaERz+wUIvdieXMHjbid0Aaq1P4o0q05y
         VJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741696736; x=1742301536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Zq92IivDzfgLqOwKYZMD/CP0Rg3YY3KQafzGl2ujB8=;
        b=q+OD7ygPKmdoaEVQsuZpFGeJACxwHoYQVxPIwpeUVMrOcmHTJmtemofs4sMZolOeXx
         xshR0wxgClp/BOpgv9RbhTF7xm+TmJEg6H2RTLB9doBGIw9i6g2QBj/xk3/wJtapDTYG
         E5+31R8XyXlwc/pJf1eyhyVUwtfyZNhwaO5mTyNa3LNXPTYkQgCSW1YGuBeSRViO5kEb
         lFqFHzaw6mOpccfeKx57euXdoP5MSXuoYIPQIon6d7puRIoP8fiOwuR6mTQu+b3tFvKO
         jP5zlk+YJsU0KlOYn7l0dwC51WquFjLOX4STHnrxY4T/yIwhpv5Pho5GKZIRGaB5zZ+o
         41dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRShb0oVL6nY76VTaC7Mh175CkDl9Paz+3v4gYaC7RNLNBMABiFUulCCGQcKilZ9exm/Wk@vger.kernel.org, AJvYcCWrrsvSN/sLssIy8DESt8lNpFo49wyanexOLymQ5OZoQktApBMCsqAG3XnLlMVNMyEgAFadxwF0vEBqElI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlAK1CS2MHekITFVa44dVj1XAeWOGaB7R6Zyz7vlGRjCvjuYYm
	6UP5RJw4SQku31Og6ilmj5EAJ35+nGPMfDEfO+Bj7CeVl4WGPCwr
X-Gm-Gg: ASbGncsOaef8Qg4zhKvhiN9d7mVEU0PyRNt/P8WGZPZgBuhB2aoFt9m9LsFfARP+0Mv
	llVgDvgjn+ARRYaW1D6NGTrWpg+r/uI5DnwYtiw1yb2TWaqePj5QxJxHNaCPvPtDQEm9tH85V77
	2FEu/oBeHi/Rg+ahWY3T0lNO7/JLdZynP+oX7SPF0CSbGS5KJTBa6IUVaeTjsZO+FKMvOzfaEnQ
	H/nIaaCOjdaQs3agzUCSkr4f+UNEcnw+kOIA3nP7Nmf8+C+EmfQy53MDhPxAZKQvYJAHzK/5uy9
	K49X084wP20PNQeGTdw8Tu0z/4ViTPgZasI9aLagwwxEcwkrC5A7J2dy9xXpJ8Z15YA=
X-Google-Smtp-Source: AGHT+IFVSDfkDIFA/y0QFEveP3iRhGPEoi94T2fCmGV+zq3Tl2ugxm8Fdk/1pXq/YAIpEwzep6LdRQ==
X-Received: by 2002:a05:6512:3086:b0:549:8c36:592 with SMTP id 2adb3069b0e04-54990e2bf7cmr5708280e87.5.1741696735989;
        Tue, 11 Mar 2025 05:38:55 -0700 (PDT)
Received: from pc636 (host-95-203-6-24.mobileonline.telia.com. [95.203.6.24])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae465cdsm1767911e87.21.2025.03.11.05.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:38:55 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 11 Mar 2025 13:38:53 +0100
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v4 3/3] rcu: Use _full() API to debug synchronize_rcu()
Message-ID: <Z9Au3RWVt9ERrea6@pc636>
References: <20250227131613.52683-1-urezki@gmail.com>
 <20250227131613.52683-3-urezki@gmail.com>
 <20250310015507.GA3993297@joelnvbox>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310015507.GA3993297@joelnvbox>

Hello, Joel!

> Hi Uladzislau,
> 
> On Thu, Feb 27, 2025 at 02:16:13PM +0100, Uladzislau Rezki (Sony) wrote:
> > Switch for using of get_state_synchronize_rcu_full() and
> > poll_state_synchronize_rcu_full() pair to debug a normal
> > synchronize_rcu() call.
> > 
> > Just using "not" full APIs to identify if a grace period is
> > passed or not might lead to a false-positive kernel splat.
> > 
> > It can happen, because get_state_synchronize_rcu() compresses
> > both normal and expedited states into one single unsigned long
> > value, so a poll_state_synchronize_rcu() can miss GP-completion
> > when synchronize_rcu()/synchronize_rcu_expedited() concurrently
> > run.
> 
> Agreed, I provided a scenario below but let me know if I missed anything.
> 
> > To address this, switch to poll_state_synchronize_rcu_full() and
> > get_state_synchronize_rcu_full() APIs, which use separate variables
> > for expedited and normal states.
> 
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> 
> For completeness and just to clarify how this may happen, firstly as noted:
> rcu_poll_gp_seq_start/end() is called for both begin/end of normal and exp
> GPs thus compressing the use of the rcu_state.gp_seq_polled counter for
> both normal and exp GPs.
> 
> Then if we intersperse synchronize_rcu() with synchronize_rcu_expedited(),
> something like the following may happen.
> 
> CPU 0					CPU 1
> 
> 					synchronize_rcu_expedited()
> 					// -> rcu_poll_gp_seq_start()
> 					// This does rcu_seq_start on the
> 					// gp_seq_polled and
> 					// notes the started gp_seq_polled
> 					// (say its 5)
> synchronize_rcu()
>  -> synchronize_rcu_normal()
>   -> rs.head.func =
>      get_state_synchronize_rcu();
>      // saves the value 12
>  
> 
>  -> rcu_gp_init()
>   -> rcu_poll_gp_seq_start()
>   // rcu_seq_start does nothing
>   // but notes the pre-started
>   // gp_seq_polled (value 5)
> 
> -> rcu_gp_cleanup()
>   // -> rcu_poll_gp_seq_end()
>   // ends the gp_seq_polled since it
>   // matches prior saved gp_seq_polled (5)
>   // new gp_seq_polled is 8.
> 
>                         /*  NORMAL GP COMPLETES  */
> 
> rcu_gp_cleanup()
>  -> rcu_sr_normal_gp_cleanup()
>    -> rcu_sr_normal_complete()
>      -> poll_state_synchronize_rcu()
>        -> returns FALSE because gp_seq_polled is still 8.
>        -> Warning (false positive)
> 
> 
Thank you for clarification, this is good for archive :)

--
Uladzislau Rezki
