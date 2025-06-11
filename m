Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E76D25EF9F;
	Wed, 11 Jun 2025 09:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749633931; cv=none; b=N701ygNN/CGXUQue8fNNF7aiuCmYgn1qRM65HkEo+mm5HtK8DuacdqWAbXuQfztN8a+rl6yqGRO0ahs0XirHfO5I/pFjzs2YvxDESTNUOb31gNTIwfkCkXvZom1SVklpJX2NRM/OGgSYDVeckgczHf8wKDB8KihotC31FPKBVA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749633931; c=relaxed/simple;
	bh=8aW8flzpOEdNvRpnopc7kcDgqLYryCWboV6UFdlDTtc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/6Z6ecdqwCkx9WQpxJ6woPGisuSbsLXX5qEdBzAkrWG0gamBZPfAI/UAW0RW9iPRW7/wV1l8g8PMTs1kcEdhkYHop+ejC8LzZGreJzJVwUd85YOY1dloNp6DApIreoJQKFbLg4RbdkswhCh0xuTc7fZULBWt4IVq9rxgQgu0Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Auw87Ly1; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Auw87Ly1"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55324062ea8so8300885e87.3;
        Wed, 11 Jun 2025 02:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749633927; x=1750238727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fXw9bUaSPUDIhkRTBLBFq1NYEmQDUusclN78B59JQTs=;
        b=Auw87Ly1/lOQdIZRyhzXxLmzavFmZRtx7ZCswY+F/35S44246EE82M/0Dz4VIIl3Ey
         oRNULPUvHqJRLlyrlkNLjQ/webv8L5DX35WE53JfvLj7r4pbBdq63PZ3Z/zsNx99iOmG
         0Hue7AthQxXxSJqj2ncFb8+xUDeQyr8FelEW7vXpBKfptWmrXYO9kUsOGHCTq3kImkXF
         D+B6yTsNRvUQ56F7LkVzJfVHKVhu/Ly+f5i13QcMghLADYkeHAWH3W5JdxjE/U/hkHyR
         IpPUvex/vEBdLTp2WclARfZcM5j5ILImTHiA9r32LpCEVv8ugUN122xJk+jzR6h4mNGa
         pWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749633927; x=1750238727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXw9bUaSPUDIhkRTBLBFq1NYEmQDUusclN78B59JQTs=;
        b=JfK0HalhwWMOa0F8Lh1tND01/T8q31mL1dypctZX4pNq4dE9Kbcdeyuu94Dp/2J3dl
         DOEpbvEh26WVL3kx+3MuNuqBr1kUdsIC6O6zRRtD/N6/1Yhe2hAuY3AO2Wb41hwLCnuf
         dPsP20qNqfiJQquN10ZpAtWIVN9R+Hp1z+1QiiaUOP1Y55hZihFyCoFjWiy/lLHKQmMZ
         hJ0xayLnhlbnTYO8wHFC9Pnyv37ZA8JelCtb3i/mWFrue+ywSc/WZSioKOOlxyOQiJlZ
         ODSuT+/eNz/VwVpoD7UWCmAKh6SZKPFVyLK7xmV1wmn8H1wQ3QzZZFOgeYtJUoqhrp2z
         TGSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWld2KDkQdiGEXWfC+b7khgO0bfyv2NxNLRS4X+vxMYu4tayIPNCGqjT3vIxZTilNyMXYzF@vger.kernel.org, AJvYcCXcEzZPU9qQmL0i1b79bkXxxcnwZ4Sd/+LjEHGHvTfKhXS2S+RPocJVKIhAvCQ6Qse3wAWaXLM8KIGFX/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQM8lDXMO+RGvVGU6B9W/XHEMCoWtqOfSPG2fs+97r6ijy3J8d
	BBkjzyUsnsw3u9TshqENIiMWLQVEYQKUfAmvgcpfAUQOrLD6uAmwWkkU
X-Gm-Gg: ASbGncvVMdKoq3a0k1ZFdbsMgHzgUF59HLVqs2JDQykAgowsuGh+qoymLCSpM1Rt/ki
	XBLWkDd1OVeUDPuBCme85R0xzEF5EIKDoA6X2XlQxtwo4t7X6coUNnI0RoW2eVEbmkN+bYg/6lw
	g/qRHJNqh8qYB4W4fesVfuULYRlxmBRyySi1FAyVWtzSYfaorg4wylZpvnCdoHsyAyj9LqTh8EV
	jhxE+vtcbIwGxtNb5af6xF2x9YQnyLX3vQol3iXMXe4OE1sFWhfVQw29I3bzMCkqlG9W99vQnzL
	qB+5zsAzoa4ZnSRnf/HYMpyUuey0y4mcPvW21g8QPrWUd6IZDkvSXaUhAPTRxcrRUgqJ+nUr3Fu
	kGmoNaFcFxzU=
X-Google-Smtp-Source: AGHT+IE4/yCpbfHpcXtf/o5H6UJTebK3DlLJ8pKrDj/PBzsS1Jglkar8iIrHhFY93Nv7YSqKZWm9mQ==
X-Received: by 2002:a05:6512:3e14:b0:553:2ef3:f73d with SMTP id 2adb3069b0e04-5539c10ae42mr784428e87.14.1749633926976;
        Wed, 11 Jun 2025 02:25:26 -0700 (PDT)
Received: from pc636 (host-95-203-1-180.mobileonline.telia.com. [95.203.1.180])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5536773197asm1879585e87.213.2025.06.11.02.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 02:25:26 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 11 Jun 2025 11:25:24 +0200
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/3] rcu: Enable rcu_normal_wake_from_gp on small systems
Message-ID: <aElLhFVlf-p5YWaq@pc636>
References: <20250610173450.107293-1-urezki@gmail.com>
 <20250610173450.107293-2-urezki@gmail.com>
 <d55a7d1b-d0c0-4c04-b69e-ca6737c98224@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d55a7d1b-d0c0-4c04-b69e-ca6737c98224@nvidia.com>

On Tue, Jun 10, 2025 at 02:34:10PM -0400, Joel Fernandes wrote:
> 
> 
> On 6/10/2025 1:34 PM, Uladzislau Rezki (Sony) wrote:
> > Automatically enable the rcu_normal_wake_from_gp parameter on
> > systems with a small number of CPUs. The activation threshold
> > is set to 16 CPUs.
> > 
> > This helps to reduce a latency of normal synchronize_rcu() API
> > by waking up GP-waiters earlier and decoupling synchronize_rcu()
> > callers from regular callback handling.
> > 
> > A benchmark running 64 parallel jobs invoking synchronize_rcu()
> > demonstrates a notable latency reduction with the setting enabled.
> > 
> > Latency distribution (microseconds):
> > 
> > <default>
> >  0      - 9999   : 1
> >  10000  - 19999  : 4
> >  20000  - 29999  : 399
> >  30000  - 39999  : 3197
> >  40000  - 49999  : 10428
> >  50000  - 59999  : 17363
> >  60000  - 69999  : 15529
> >  70000  - 79999  : 9287
> >  80000  - 89999  : 4249
> >  90000  - 99999  : 1915
> >  100000 - 109999 : 922
> >  110000 - 119999 : 390
> >  120000 - 129999 : 187
> >  ...
> > <default>
> > 
> > <rcu_normal_wake_from_gp>
> >  0      - 9999  : 1
> >  10000  - 19999 : 234
> >  20000  - 29999 : 6678
> >  30000  - 39999 : 33463
> >  40000  - 49999 : 20669
> >  50000  - 59999 : 2766
> >  60000  - 69999 : 183
> >  ...
> > <rcu_normal_wake_from_gp>
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  kernel/rcu/tree.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 14d4499c6fc3..c0e0b38a08dc 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1625,7 +1625,9 @@ static void rcu_sr_put_wait_head(struct llist_node *node)
> >  	atomic_set_release(&sr_wn->inuse, 0);
> >  }
> >  
> > -/* Disabled by default. */
> > +/* Enable rcu_normal_wake_from_gp automatically on small systems. */
> > +#define WAKE_FROM_GP_CPU_THRESHOLD 16
> > +
> >  static int rcu_normal_wake_from_gp;
> >  module_param(rcu_normal_wake_from_gp, int, 0644);
> >  static struct workqueue_struct *sync_wq;
> > @@ -4847,6 +4849,9 @@ void __init rcu_init(void)
> >  	sync_wq = alloc_workqueue("sync_wq", WQ_MEM_RECLAIM, 0);
> >  	WARN_ON(!sync_wq);
> >  
> > +	if (num_possible_cpus() <= WAKE_FROM_GP_CPU_THRESHOLD)
> > +		WRITE_ONCE(rcu_normal_wake_from_gp, 1);
> > +
> I think this will get weird if user explictly specifies
> rcutree.rcu_normal_wake_from_gp=0 ? Then we're silently overriding the param.
> Maybe, initialize it to -1, and then if it was set 0 by user, don't override it.
> But otherwise, set it to 1.  Per your third patch, '1' is a default, not a
> forced value.
> 
Right. That case should be fixed.

--
Uladzislau Rezki
