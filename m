Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C96A1CC8AB;
	Fri, 25 Oct 2024 09:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729848790; cv=none; b=gn5FUZnz8j8+VQYMBeRNAavcuYdD3s5ddZ4qMMaxr4y5W6wq3oSddlK4dNp9AJKAc5bWjW0T2tXd8+l6CHQZ5MR0I5u/672oGC3O0kwB8oWgJdmQqASYxaMbnRpPllw519HLFhqI7wSkn2KcOaeVfnqllB2HrwWgn6ZBeViDQNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729848790; c=relaxed/simple;
	bh=WU5i/oz3Q2KfA5ucnzItRkFKrJXhRwqm2jMYZgIalvI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ss1CRv0GaJvi8z8lvN6F/+1+p8NrSkGBkpYbwoiRl9eZi6DqmFT6ZsvSyB894zhzQYoudUSnS2H28CghPJZWuG/6GbpB7zYOJZgWRk5J4M9doPDQNqrhkObsz2TuQXaazm8wpGs5k9HjrD80BgvaXQlIdKcnAicjBijHn0Uf1wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V144Mdi7; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V144Mdi7"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb5be4381dso20039781fa.2;
        Fri, 25 Oct 2024 02:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729848787; x=1730453587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E6QTZZUZpkS+MVjW2wxMAcKK+NegLhjjo1PPouQ2ABY=;
        b=V144Mdi7zQQ4+pxSC1zhKChvez/qq9fEZisHh6TPO+N6bDtbVapwK3vEP68dlk1vtM
         S1JpUfUFr4WefD9xMnpFxEyZu6Y46R9uB9QqonNjHRxPif7t5l0VFHtE9l3mNHAEeBbB
         BkxYqY7FWzMQbojFdjQnmiHGan6LSVCgu77z7MgYKd3mZWy+SBl1JKySgV4c6k/GSbOu
         3Gphy7iLOMq+UjFz9EgjV84u+2MjuoG5BxJ0h8fbyE7UjpGuiMmF13iTEf49cNrHw50u
         da/B1DU87/XZsBRWZrplTRRuYjxFDTzoRhms00WFzLOnoZE767cWWnQJtSyu+0OS0mhI
         6OGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729848787; x=1730453587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6QTZZUZpkS+MVjW2wxMAcKK+NegLhjjo1PPouQ2ABY=;
        b=gHGgd1lVXa5iGNnI//LeShkhojySZ2HC4RF1mYV0ypNcH5TavticqcbUUFp5OZ3YsI
         u95HDTbvpjG76UH/Ilhjijxshae0J9JBW7SLQVB/pg2Y1UGUm/E0j6Qzl7LVAjSZimfm
         u8IXmezHDAFQbyg0bo8GpG0lC87/kTAJogPKSZkgG0m0J9xOGlNGRANJVgHHKwtrumV4
         ag9EhqphAX2zXT+SnHz2p9ll9vP9KFTLpqclWQHVLj611eMEKq9yR5xaHhI7OBto7h+K
         FViH2o0i0RGJupaPjH8rBhGefSiTCoKW1s0xrxZ4+QRtYRzpQC9jGsHWJntMmryHaI2O
         Kt3A==
X-Forwarded-Encrypted: i=1; AJvYcCUG4l0yF3iajhgAsQFx91+yfQDAMaVvyjsis7grRk5t+99QNDQ2dWu2ACEM5r1aOP5TMfMW5Pc9P3aKanE=@vger.kernel.org, AJvYcCWT3cHdq0Q+GglF8wfzkbJJvF6I97saORR18AaYnR4gz8eS0foG0z9o4lALsd4A38aQZeYd@vger.kernel.org
X-Gm-Message-State: AOJu0YxXdkCY039jInKJzNVM3IbJqZtRLud9s58Oczt9rh0hAJ2OXQ/7
	hhC3K6L+E7JVU46TYyYBuN8+T/AZeXRGxqbh+Vxk+I1gN9RgrJrBi2VGXw==
X-Google-Smtp-Source: AGHT+IFFDjBggIOgPv+qcArJP6ckgouolVPde6kgklfA9zCScEQtU6QBEdnnon6PRqmaipp3rytOTw==
X-Received: by 2002:a2e:819:0:b0:2fb:57b7:5cc with SMTP id 38308e7fff4ca-2fca8262d50mr23531281fa.36.1729848786218;
        Fri, 25 Oct 2024 02:33:06 -0700 (PDT)
Received: from pc636 (host-90-233-221-2.mobileonline.telia.com. [90.233.221.2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fcb4507b90sm1196191fa.12.2024.10.25.02.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 02:33:05 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 25 Oct 2024 11:33:03 +0200
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/2] rcuscale: Remove redundant WARN_ON_ONCE() splat
Message-ID: <Zxtlz8LeOs3l20c0@pc636>
References: <20241024164558.715296-1-urezki@gmail.com>
 <20241024164558.715296-2-urezki@gmail.com>
 <640af17a-958c-4321-89d4-8ab1f12986fb@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <640af17a-958c-4321-89d4-8ab1f12986fb@paulmck-laptop>

On Thu, Oct 24, 2024 at 01:28:24PM -0700, Paul E. McKenney wrote:
> On Thu, Oct 24, 2024 at 06:45:58PM +0200, Uladzislau Rezki (Sony) wrote:
> > There are two places where WARN_ON_ONCE() is called two times
> > in the error paths. One which is encapsulated into if() condition
> > and another one, which is unnecessary, is placed in the brackets.
> > 
> > Remove an extra WARN_ON_ONCE() splat which is in brackets.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> For both:
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> 
Thank you :)

--
Uladzislau Rezki
