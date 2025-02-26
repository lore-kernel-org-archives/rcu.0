Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5212248AA;
	Wed, 26 Feb 2025 15:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740585501; cv=none; b=EYSQjtpfIFV0yB052ZybxLlvaeC1e/jQGUM7aK7Zv45/3tdjxpNKxVRZd6vWCsqx0fcxh1y3OchNIKqpRUFqi0HpGARu9P8xZzh3asATb/qjZbtIFD7R/9soDaWx5jsFNUfM1QolSO7oheYkWdb9a+FvXf3KHXLepW8l6e49qXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740585501; c=relaxed/simple;
	bh=bi7dxO8VrMjY04k/8cRy3LMKbXlmdupQE/VilQ+toKk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbDc7BDqBOIKRPTOpqGzMJvjE8SRPmMmYSUtfiJ7ESd8ctyyQhyJCmOAqlPQiU25dNJc9UH3SJ4TavEMywwmXq79O74WzpvD/4378curCWITfSddLJ5e06JJEGdDhnZ4Pd5+asO3XOr+lE5EhR52VjILIkhoAdC9bmB4omRCx04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RiAS+TvU; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiAS+TvU"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-307d1ab59c6so78422931fa.1;
        Wed, 26 Feb 2025 07:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740585498; x=1741190298; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RITIVTCCbPTEmlznoBvDtT81aFPY1TF+qiJ3KGGJkqY=;
        b=RiAS+TvUjGRHK3ZdsGFNDAP6u/k1ZzN99qqOJwk981O/J67ybcZFujp+zoHlv6A3Fg
         92+cytPKIhoocD0IjzYqhFIQ1I3uTW2rNydvXsgFormLC+IkJKZFq3DjWG1c1Cr6vAiA
         BHYZScxCa4FnG4zacP7luooAS6d8OjWh5ctYKbUk+qsaPi4V09TeetjhJN5sVLglSV/A
         puTLc3jZVwDpWiubxxLp6hgQmlJnHhYi/RfPOQQLCx5CFpEGrDssmpzx8Vvq0+ODrjwU
         2WF3RpXysmSY5MWSBZI/01bZYIvC3ILHyQ0Zx9os5I1Ijtb9CgmPfOW967tG9mvFbNks
         VgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740585498; x=1741190298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RITIVTCCbPTEmlznoBvDtT81aFPY1TF+qiJ3KGGJkqY=;
        b=TsplrwYvF2OQ0yCVlzJb2EKRZ9f4wk6L1lTi5syubbdg8mW+1chpHN/q6tSqr9VriY
         s7rOx3qDL+dyBZd8y1hyjjnKZMDGtXugU+wDyjBVa7N0ECDM7J3STn2muJAVl1HO3MLm
         I6wiomBAIQldZ3F9+HDUEj6Ryr5kajoLwNyvnlzOsaqAlqePfKpMz2StTr1M8RB7dwf3
         ojCezOSRBaF+MaKQq8YH64emPYuNZ0a4PzNtrBTdcPYkU4bvsqE7gHAQtU4VsWZIaKT7
         HRPzJyXQIRnnZoH91UYu+p9OMfkxnVzMNTlUTy8rqd5wTF9CLqmdqrvKWB2JnKIeAGUQ
         tihA==
X-Forwarded-Encrypted: i=1; AJvYcCUl+gMhcbYWbsmBtcWzo0TLk1EcU7PGJ45zaeDYFNUL7O29duGI45au9YlaVhVV2aXfIdc2@vger.kernel.org, AJvYcCXmkHbY1SSzgdozc5dk3S5zN0Lrqy8PfdVlLKBjXmjc831owSaZUC0gqdY/0SsFiHhTNE+pvYj8rdG/owk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqm2DGenrcXGHH0C+sAUTb7V4PbfLrqiXcmGOZcBTvFHPF648g
	5QomElH5XEqmRfw4sSHcpJQ8ek/ld7ehiCFa1T7ZtruLU90cmBxO
X-Gm-Gg: ASbGnctpPfttYPc568x/3A7FLuoirJF+hHg/kF7nm+hC6lFZ/SyYt3UDmK14w9Z+cY5
	Mm5u5ez50hhDzEsR8n7/DYmCrLxeVbzHbmGDnUabylCWezbr3xPTtcc+XUwuR7lnqP2rINGnO10
	WH2Z9NoPdhKeFMeCyl5QYbomSuECfsxcpC8Z1Lgrw5kgkwOMPCrL4tIK+9XdYf3QkQ+4CXcGng7
	4Lx9KpItYCOS75vorQlrG1JPQ0Hkq8+12ppbAjgI6ahyF3Iw/88YvvOHSY360kBMFd+z7rQ0buH
	SbMqNCzrx2gGcpyb6tRb1zR0qCsinaCKAo5I2VXzhRsW0lAf
X-Google-Smtp-Source: AGHT+IEKepRkgCxNHEffmBxHyGo3LSSp/FaDq2MJoUWianme6+1VXGIKpH8gZ7BIYRCP1hqyTay2dg==
X-Received: by 2002:a05:6512:3e17:b0:545:5d:a5cd with SMTP id 2adb3069b0e04-5493c570908mr2649719e87.6.1740585497794;
        Wed, 26 Feb 2025 07:58:17 -0800 (PST)
Received: from pc636 (host-95-203-6-24.mobileonline.telia.com. [95.203.6.24])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514efaccsm491496e87.155.2025.02.26.07.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 07:58:17 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 26 Feb 2025 16:58:13 +0100
To: Keith Busch <kbusch@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Keith Busch <keith.busch@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>, Christoph Lameter <cl@linux.com>,
	David Rientjes <rientjes@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Jakub Kicinski <kuba@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	kasan-dev@googlegroups.com, Jann Horn <jannh@google.com>,
	Mateusz Guzik <mjguzik@gmail.com>, linux-nvme@lists.infradead.org,
	leitao@debian.org
Subject: Re: [PATCH v2 6/7] mm, slab: call kvfree_rcu_barrier() from
 kmem_cache_destroy()
Message-ID: <Z786FcgpcjVZw4WI@pc636>
References: <20240807-b4-slab-kfree_rcu-destroy-v2-6-ea79102f428c@suse.cz>
 <Z7iqJtCjHKfo8Kho@kbusch-mbp>
 <2811463a-751f-4443-9125-02628dc315d9@suse.cz>
 <Z7xbrnP8kTQKYO6T@pc636>
 <ef97428b-f6e7-481e-b47e-375cc76653ad@suse.cz>
 <Z73p2lRwKagaoUnP@kbusch-mbp>
 <CAOSXXT6-oWjKPV1hzXa5Ra4SPQg0L_FvxCPM0Sh0Yk6X90h0Sw@mail.gmail.com>
 <Z74Av6tlSOqcfb-q@pc636>
 <Z74KHyGGMzkhx5f-@pc636>
 <Z784iRR13v6SkJv5@kbusch-mbp>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z784iRR13v6SkJv5@kbusch-mbp>

On Wed, Feb 26, 2025 at 08:51:37AM -0700, Keith Busch wrote:
> On Tue, Feb 25, 2025 at 07:21:19PM +0100, Uladzislau Rezki wrote:
> > WQ_MEM_RECLAIM-patch fixes this for me:
> 
> This is successful with the new kuint test for me as well. I can't
> readily test this in production where I first learned of this issue (at
> least not in the near term), but for what it's worth, this looks like a
> good change to me.
> 
> Reviewed-by: Keith Busch <kbusch@kernel.org>
>  
Thank you for checking. I will apply this.

--
Uladzislau Rezki
