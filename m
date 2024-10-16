Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19C11CAA6
	for <rcu@vger.kernel.org>; Wed, 16 Oct 2024 00:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729036892; cv=none; b=Qz58hvUC40k2c2M6rd4Hqterqh4nZruBXRls2B3kPmsCrsSx6PXWZBg1kG4bwJkswXyio85i1aWtSwTt/2KiVXKz25us/BNgFHTPYSrDDTQhPaMotnHJbSPkdXu7KwQpOOQgEC6OaxVZX35tC+gcsTGDlJ4h+4dXVOl8RdedeJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729036892; c=relaxed/simple;
	bh=ZJMHfdFl40Jew9Db8fPQXUqbsd6wtiGA37UqAtoMAKU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qU56HRUpDkBskRm/4Rkx3FnUZZF6DHNZ60Cp/8k6m39JvhnbKoxXuhbj0mt4CfcR5gR/7JXV/KO2rcTePZpo0vZE2GPaXl1J2AWlbFoCB9KXsuOICs1wo4RRJMPVOsuN3WWSfaVGj3ajpWAKLWou28lgIDkpv1xn5E2hfdZTAlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=mbtChjbV; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="mbtChjbV"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6c5acb785f2so31241546d6.0
        for <rcu@vger.kernel.org>; Tue, 15 Oct 2024 17:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1729036888; x=1729641688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xvFHgFKvO5/gieDiOaoU8RXGfIAzjnLuO2tCqQ4vsXo=;
        b=mbtChjbVRxj9rwU6g1BSVAupZSC05M4VfSDFgiE3A4QAWpO9AS4yEu1eANyX8zYwCc
         mNOe3t/1x6TYTIMyGJG8axFaCm9aRmNOIo7hvMvi6ysSxdSb1g7LRqzGsbQ7Pvl6iK1j
         OW+urcsVi0TVx8KchUGObERC2DiyQfzfG1MSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729036888; x=1729641688;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvFHgFKvO5/gieDiOaoU8RXGfIAzjnLuO2tCqQ4vsXo=;
        b=HN1tegMGj2CdCbWz8+z5uawTF1MabzDBHNcl5xrHMxE18Q8LhXbD7MgGeyRBegiDtf
         NILVM+O7W8Nu2pkOkYgmwouxtYVsQXAcsWt+K/2K6f+5QfXTDjxvX3GkAxp0nQlgJMqU
         INlYjiEpj8SpGjUM36RUL9ugoOS+rN9EjuPQffvLvL3VwM4oiFo7AyvQDB0zyA82qwMh
         BQbjMGNfU3tamEdW74A/YQxg3R5dm6vWgG9aMQW4/CdXFp3nzd/Wi6hypGDfUE8pdbQU
         HkopuXblc5fzEPg8+S3I7LIm6cnY7JaguXT5N2SZNwh0mvWE0mhUq0CRN8xkhuu9Bzry
         M2qg==
X-Forwarded-Encrypted: i=1; AJvYcCWtI+vW+PFcoY5ufYmoWX2X0NdZPHvZI11+CC+e5gfGF/3Uk4YNvBGGtkrLiYbYt8R75aw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk+/iG+/bX78iE6Wm6KnPWRYjhWC1FysE7elD1PqoG0StvDuj5
	5AbG4+2HNmSSllvqvR836tD9/ny5OaJMzmcYgLc9xxeOWFtE2rpGWhYD2w4C2CA=
X-Google-Smtp-Source: AGHT+IGFUHOVYpa5KmX86teubmJx9xKEjLJnnz6GJHUgs88i09coAXcRd+X6WZKxdB3snA1E4wz6SQ==
X-Received: by 2002:a05:6214:4343:b0:6cb:728c:8bd6 with SMTP id 6a1803df08f44-6cc2b8d7140mr28758546d6.27.1729036888552;
        Tue, 15 Oct 2024 17:01:28 -0700 (PDT)
Received: from localhost ([91.196.69.99])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc2290f962sm11957356d6.13.2024.10.15.17.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 17:01:27 -0700 (PDT)
Message-ID: <670f0257.d40a0220.9c8db.5c21@mx.google.com>
X-Google-Original-Message-ID: <20241016000123.GC973@JoelBox.>
Date: Tue, 15 Oct 2024 20:01:23 -0400
From: Joel Fernandes <joel@joelfernandes.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: frederic@kernel.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, rostedt@goodmis.org
Subject: Re: [PATCH rcu 0/3] RCU CPU stall-warning changes for v6.13
References: <fb0b7a92-d371-4510-80c4-25a57f2c4f3d@paulmck-laptop>
 <670eb924.050a0220.63bb1.4746@mx.google.com>
 <f5a833c4-6346-4ec4-8360-4a818342fb52@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5a833c4-6346-4ec4-8360-4a818342fb52@paulmck-laptop>

On Tue, Oct 15, 2024 at 04:02:37PM -0700, Paul E. McKenney wrote:
> On Tue, Oct 15, 2024 at 02:49:06PM -0400, Joel Fernandes wrote:
> > On Wed, Oct 09, 2024 at 11:05:02AM -0700, Paul E. McKenney wrote:
> > > Hello!
> > > 
> > > This series contains RCU CPU stall-warning changes for v6.13:
> > > 
> > > 1.	Delete unused rcu_gp_might_be_stalled() function.
> > > 
> > > 2.	Stop stall warning from dumping stacks if grace period ends.
> > > 
> > > 3.	Finer-grained grace-period-end checks in rcu_dump_cpu_stacks().
> > > 
> > 
> > Other than small nit in 2/3, 
> > 
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Applied, thank you, and I also added the data_race() in 2/3.
> 
> > I was curious if you're seeing perf or other improvements with the
> > finer-grained rnp locking.
> 
> This is about robustness rather that performance, though I suppose you
> could argue that lack of robustness is an extreme form of bad performance.
> Holding the leaf rcu_node locks for too long while dumping stacks can
> result in things like CSD-lock timeouts due to the dumping CPU having
> interrupts disabled for an extended period.
> 
> And earlier commit, 1ecd9d68eb44 ("rcu: Defer printing stall-warning
> backtrace when holding rcu_node lock"), took care of most of the issue
> by deferring the actual output.  But while in the area, it seemed wise
> to avoid up to 64 dumps being generated (but no longer printed) while
> holding a leaf rcu_node lock.
> 
> Hence this commit.

That's smart to do and makes sense, thanks!

 - Joel


> 
> 							Thanx, Paul
> 
> > thanks,
> > 
> >  - Joel
> > 
> > 
> > > 						Thanx, Paul
> > > 
> > > ------------------------------------------------------------------------
> > > 
> > >  b/include/linux/rcutiny.h |    1 -
> > >  b/include/linux/rcutree.h |    1 -
> > >  b/kernel/rcu/tree_stall.h |   30 ------------------------------
> > >  kernel/rcu/tree_stall.h   |   35 ++++++++++++++++++++++-------------
> > >  4 files changed, 22 insertions(+), 45 deletions(-)
> > > 
