Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F274E1EEA36;
	Tue,  4 Mar 2025 10:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741085785; cv=none; b=N4aLuT7VDBXUsVIOKmaT040pOLNfbWhyNh6BglEe/iP674O5RiECrudUKLs0aVgi4GIvnzP5bBRxlFiONC4D7qy0o5IoevCOEkX2EQsA6Ydtrwcl7kwfTDjvNsGya6UKS4jM1LvPg+M7KNogH5RKgVVzkkGPn4rz5oRhWMtpz2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741085785; c=relaxed/simple;
	bh=2kGF20McTMFx0eUue31jMUlOjQ9gcD4Iwep/bNKlJ5s=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtDky47SrYPD8I0yjRgeuvOf4wka1FiyeSIiOkMHfX6mq53ItQFUEsbwtG5kRPAe4I3ZWSB/YDZ4VglhosXnO9lfwslfHMxahVwkiNG+4J4saljghGGwz4NP1YxASFPCV9b7oGnfsX5nnFfHu5T1K3mjkOfl5mGya4OG5fNedYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ut2IkYiT; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ut2IkYiT"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30761be8fa8so59488741fa.2;
        Tue, 04 Mar 2025 02:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741085782; x=1741690582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O95iyxsB97GdILIsg3CJ17biJahUULxaDIffyMB/KYQ=;
        b=Ut2IkYiTZQCFmHrho5HO0az0GOLmvOwsf+5SqTrECg5o6njqA+WFypc/mHKhoY3svq
         S+qArNiKqy3brrQ1zdsO0rDS5gAx8ECp853mK5hYWVXkKr/jORctqnN5AFlm4c58+OLt
         NPWNg9Jgn4aHpYe9VUqAMCrNGHG7Hd51QSxqK+A/FJcRwnJhowDFfefjVm28rSuH/b7e
         ISsq1y8b5HIi10OUV4qsDEEWUJrTijuHBaGJFN/YkzTu/shy+3NCvQmUEwe9Q4ST4JZh
         2cQ6DztE/DkPsrE4YtbcSWnILeo/leeKrMg2XUQSQV0x5B+hqL4i52hk0f5CzNNYXHkr
         lsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741085782; x=1741690582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O95iyxsB97GdILIsg3CJ17biJahUULxaDIffyMB/KYQ=;
        b=kA7TKKvXzGf8PAYg0zRUrb3lYSLOYdweBT5jMHEYwQ2U09CT8aT2MlYCMxwfngib1Q
         MfrfvLLoXRXe7CDADUYQAx/5zV/1Do9zhx5MB5we6AC2VwJXuYKHwHXXsMsHCnnEYrkF
         xbw3+gt0sBI5YKQlIj4j4/jcyI9WvLBGJsUw6+URIu6wXeAblaGgJdP2gLT+/8vF20lx
         XEO/YcwYvE9Dt2jrVjc7eeP0fG9tMILQyK5sK3w+twT6xSWzEqm0X6IA7joIHbQal5YC
         W3++yZA1837+V4vioqM1eiO3BAoLx5E9UtputFWHfzASJa8LYA4Tke/B+mC+5c7a5r9F
         dHHA==
X-Forwarded-Encrypted: i=1; AJvYcCUSrBUoGMhh3Ek3yOyjFYnauGdOisNLdPD3CSCbqto4GEyTgVrMMz8NjkjrE3r1cZUg2MYO7+NOfAdyey8=@vger.kernel.org, AJvYcCXNxgA5EgfPGQ0KFLhmLeYIrbjuJvKVMP4nQOlgl1mgwmCwWe0AlLf3mn8KVERsHfqfj3gl@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Dm8aaIMDwhnr02MTK+8+ycIh/afhgJVJRMBrXO/DrmNf0EEx
	mPfa9pUV1/0QuPTtfIIUKk98NO2OivyEJ/mkU+zRHreDpABzE1+8z6lGgg==
X-Gm-Gg: ASbGnctdSYvgIaifY+MYI5WYJHVt/s6EJMuh90TWEF8e5TjeUJ1fABRYxqMp6GHvXwe
	vsWZThAL9zQBSIvbF+nu13KY7GkgdJPevTuXuGNNxWlGB/tiTQBgwZbdrBOIIFbWSFw+NaT/CRG
	TVhpUf3fICO7u3P/TZ6FZyjIsGJY5XJwGoAhCDgX63C4C5B6vh5TqtBxEEwSN8bhj8NR/3e2GKE
	d5D3WxGX15FchC26TAGsb7OK/ssgfrTqDCRWcAKbbz51RXBbF+j/dbFaqRuF2Rga86wepsQOqFO
	D13dEi2iMehwvPK8GSLyv5BgSc9zUj0MWkEoSqNRhJq8hssdJzTky5ZRomrFYlTQEvY=
X-Google-Smtp-Source: AGHT+IG62xsTicqIGs8h4VbHFjHjPLcnMPXMDsOyoL+7BsLuk5RhgPyDfe83OKJDbDlniqQKF969Dg==
X-Received: by 2002:a2e:b890:0:b0:309:1fee:378d with SMTP id 38308e7fff4ca-30b932531aamr62575651fa.19.1741085781684;
        Tue, 04 Mar 2025 02:56:21 -0800 (PST)
Received: from pc636 (host-95-203-6-24.mobileonline.telia.com. [95.203.6.24])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30badb30ff1sm8826341fa.47.2025.03.04.02.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 02:56:21 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 4 Mar 2025 11:56:18 +0100
To: Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v4 3/3] rcu: Use _full() API to debug synchronize_rcu()
Message-ID: <Z8bcUsZ9IpRi1QoP@pc636>
References: <Z8HmH85bYNU8enJ2@pc636>
 <dd15fa79-70a5-4929-9339-51a47099c916@paulmck-laptop>
 <Z8H_aYBUHD2sS2Ir@pc636>
 <73724164-71f4-4671-b612-eb82a784da58@paulmck-laptop>
 <Z8IKs-I-YsOoS4uw@pc636>
 <cdab57a4-8d58-41d9-a9b5-71d425a7375e@paulmck-laptop>
 <f6803081-8243-4723-a3ba-00db351aafff@paulmck-laptop>
 <20250303001507.GA3994772@joelnvbox>
 <Z8ZyMaUhXMIxX7WE@tardis>
 <Z8bbary51FZ2TsUA@pc636>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8bbary51FZ2TsUA@pc636>

On Tue, Mar 04, 2025 at 11:52:26AM +0100, Uladzislau Rezki wrote:
> > > Did I get that right?
> > > 
> > 
> > Other than I'm unable to follow what do you mean "WH has not been
> > injected, so nothing to wait on", maybe because I am missing some
> > terminology from you ;-) I think it's a good analysis, thank you!
> > 
> > > I think this is a real bug AFAICS, hoping all the memory barriers are in
> > > place to make sure the code reordering also correctly orders the accesses.
> > > I'll double check that.
> > > 
> > > I also feel its 'theoretical', because as long as rcu_gp_init() and
> > > rcu_gp_cleanup() are properly ordered WRT pre-existing readers, then
> > > synchronize_rcu_normal() still waits for pre-existing readers even though its
> > > a bit confused about the value of the cookies.
> > > 
> > > For the fix,
> > > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > 
> > > (If possible, include a Link: to my (this) post so that the sequence of
> > > events is further clarified.)
> > > 
> > 
> > Will add the tag (with the email you really want ;-)) and a link to this
> > email to the patch. Thanks!
> > 
> 
> CPU_1:                                | CPU_2:
>   # Increase a seq-number             |
>   rcu_seq_start(&rcu_state.gp_seq);   |
>                                       | add_client() {
> 				      |   # Record a gp-sec state 
> 				      |   get_state_synchronize_rcu_full(&rs.oldstate);
>                                       | }
>                                       |
>                                       | rcu_sr_normal_gp_init() {
> 				      |   add a dummy-wait-head;
> 				      | }
> 
> 
> A client has been added with already updated gp-sec number, i.e.
> "oldstate" would refer to this GP, not to previous. A poll_state_synchronize_rcu_full()
> will complain because this GP is not passed, it will on a next iteration.
> 
> This is how i see this.
> 
Updated the plain-text, removed tabs:

CPU_1:                                 | CPU_2:
   # Increase a seq-number             |
   rcu_seq_start(&rcu_state.gp_seq);   |
                                       | add_client() {
                                       |   # Record a gp-sec state 
                                       |   get_state_synchronize_rcu_full(&rs.oldstate);
                                       | }
                                       |
                                       | rcu_sr_normal_gp_init() {
                                       |   add a dummy-wait-head;
                                       | }

--
Uladzislau Rezki
