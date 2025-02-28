Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAF21F4CA9;
	Fri, 28 Feb 2025 19:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740769979; cv=none; b=Ggaet3zl/iCkktYdYQmz+imGBQfz42z51HrDdILLbYTIqe2v9zvSzFeXFFs9ohmmht4IIIiBQ83nmlxyVY7JudloESgQnnzQo6DVt+hRnilEW6KFANjNtq1Tp8Q89j+92mK3GSRb34StnyNqn/wmpra3zaka61C04EB6DSWKKI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740769979; c=relaxed/simple;
	bh=gWoGUp5l4tlCzAruVe90s9xfo62lAo2yscxiZ+ftPVs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UM9ubNYrV4hReImT8gp0mbagFKdSfEYW/oTVrc+lgKJBWOhwrfkxf1JWLD7oGVjgVZ2bTDSpUzfkiZ1Pllp7YhHsq//DLhWIElyHPPeMHeOO4w15frQEpGoyG4crCHasBhUK+B8fZLjp3ZZxHjAq6vnmYUZFrtJwxMjDaSm9gV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XX9g1nii; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XX9g1nii"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30b8cbbac91so14677531fa.1;
        Fri, 28 Feb 2025 11:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740769976; x=1741374776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QUZNpSDgpGkFfQn2cs86KMuJk2Gfvf1xU2ZK1cmMTh8=;
        b=XX9g1niiOnUMZB/oBsqd1s6rQQKAFUnM2AFv4RIvrZLrjP1sZtaUzq2fA6c5I17MFh
         rXQHAlj5NoJMlTNw5pwOieNRvpnmaitpvIRuPbRJtDLZiye4O2EP07BlND7SvwPK/v61
         yFRhJM//i0ve/cphXKhG0ShWp/cTea1IbkKbQY0uq6QOzO9R3ho4HxyVwMBkifNWSeFw
         9otTNbmdBsC4TuLpRncXh5S6ZN4gmn66fte2iPIIXDBvG8Z4MsP/gyUkUqla7Tn3fi3Z
         j3EkVL4qGGXwdLl2i100InTJuzQmAdMAW0VwT0bsydcprE0jRpUZwSjl6835G0vKsx2R
         6scQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740769976; x=1741374776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUZNpSDgpGkFfQn2cs86KMuJk2Gfvf1xU2ZK1cmMTh8=;
        b=DB/ZUBR9oCN3c7SS/KxrCiBAInUUCpHtRa4lb4QokWM1aKq/NAwhjSp5c1Ck0rSJhE
         EgigJXXg7Mhxf3c2JnWchZ4sTv/Ot5vhJLuJGKNC1yvKc2b8OlyGanDSF/brvJ5mS5F8
         sTfrtbTVNJQpkut98tyZsuZ9ZLGYPjOw5I1+ogEl+W5GbPCf6OPiAF0i3WJsbYFQ6H3P
         ERuL69qfw5MbSi1HFmdUfycFYHX+asb3vDWkA8sqCv4QxDSvX2UoVqjliL8cKgSDefID
         H9zTB28EiaxUg/ikWexrUh4d+6IfbXlobIig4i7M5ec/JXggq+NiQ+WsB2eoRO1h+xEH
         0bQg==
X-Forwarded-Encrypted: i=1; AJvYcCUB2105/KmBTRffhWGQtHqNkm3rmZYrh6uM/VmczvYEfhIGSe3n/OyhiVfpDlxKJLWAqIMi@vger.kernel.org, AJvYcCUxDB0jLVokfl/G0p8z+uV4psVweeR9DpXrHh2bv9CYIgJEKazr3q/SVUSoLHVQxGvoQ1Gw5ldoVkoyBYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL9jOlYfzYqa523K5WhKX1drbF9OwOavFq/FdP6PtuTbRy9Yea
	tM8ycvxRgZY2F+O/WdFhV76ijMlDRStsp+QKi8GBld10WQ9pR9ci
X-Gm-Gg: ASbGncvKnz3EebxiIzUL03e/ykhr0j6VjIdbWqMw5ycbNp6096Z/1Uipul7Y01VWVG0
	+Apg2LpbSh15f0m+HXDM0MqkEfpTST7i/cIQ2FEsOu/WVXD6z1QImjZd232LxQ8YjXeShACVnyn
	fY20VOSLOoXUn3bpgNSjfB+PUxlCg0wLjJlkr4qLCTBRZmm0alNpHMlC13wKHRCVWlDkFK5ViMz
	WLbZFVh/eYGpsaI6IH3wOtkeYkaZXqh8+gnU9iu/nDAugFh/VlrF4EEV6H1RfFNm2vdRRhRMYzy
	IsHnyY0IZx+MTewRzcXu1dKWV2Ne4dke6BZ84BC6URXHcgsN
X-Google-Smtp-Source: AGHT+IG0DM32hlqiJFdFqGAaIYtsepFNR5DdRao8e3TSieCUvK0NErcR1znSrhDjb7L2GUcdFn6lBQ==
X-Received: by 2002:a2e:b604:0:b0:309:22dc:6917 with SMTP id 38308e7fff4ca-30b90a825a6mr15247641fa.19.1740769975467;
        Fri, 28 Feb 2025 11:12:55 -0800 (PST)
Received: from pc636 (host-95-203-6-24.mobileonline.telia.com. [95.203.6.24])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30b8685b83fsm6073481fa.80.2025.02.28.11.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 11:12:54 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 28 Feb 2025 20:12:51 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v4 3/3] rcu: Use _full() API to debug synchronize_rcu()
Message-ID: <Z8IKs-I-YsOoS4uw@pc636>
References: <20250227131613.52683-1-urezki@gmail.com>
 <20250227131613.52683-3-urezki@gmail.com>
 <Z8CdB0Hzvdu5ZVSI@Mac.home>
 <d8b196c1-c1b5-4bf9-b1cb-dde8642cc34b@paulmck-laptop>
 <Z8Ckb6spK35-Ez4U@pc636>
 <1408fc88-e2c6-4f49-b581-0e9ad5620fe0@paulmck-laptop>
 <Z8HmH85bYNU8enJ2@pc636>
 <dd15fa79-70a5-4929-9339-51a47099c916@paulmck-laptop>
 <Z8H_aYBUHD2sS2Ir@pc636>
 <73724164-71f4-4671-b612-eb82a784da58@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73724164-71f4-4671-b612-eb82a784da58@paulmck-laptop>

Hello, Paul!

> > > > > 
> > > > > Except that I got this from overnight testing of rcu/dev on the shared
> > > > > RCU tree:
> > > > > 
> > > > > WARNING: CPU: 5 PID: 14 at kernel/rcu/tree.c:1636 rcu_sr_normal_complete+0x5c/0x80
> > > > > 
> > > > > I see this only on TREE05.  Which should not be too surprising, given
> > > > > that this is the scenario that tests it.  It happened within five minutes
> > > > > on all 14 of the TREE05 runs.
> > > > > 
> > > > Hm.. This is not fun. I tested this on my system and i did not manage to
> > > > trigger this whereas you do. Something is wrong.
> > > 
> > > If you have a debug patch, I would be happy to give it a go.
> > > 
> > I can trigger it. But.
> > 
> > Some background. I tested those patches during many hours on the stable
> > kernel which is 6.13. On that kernel i was not able to trigger it. Running
> > the rcutorture on the our shared "dev" tree, which i did now, triggers this
> > right away.
> 
> Bisection?  (Hey, you knew that was coming!)
> 
Looks like this: rcu: Fix get_state_synchronize_rcu_full() GP-start detection

After revert in the dev, rcutorture passes TREE05, 16 instances.

--
Uladzislau Rezki
