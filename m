Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAAB29CB53;
	Mon,  7 Jul 2025 13:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751894120; cv=none; b=B9uTczUprlH1soR65LJ0AvkCuLxKPyoxZ/qMNdIYr/I77gBKxusJe1NgIdqvXRcWMWHxGm3UgbVO3CaqZTS49QbT0yDdWYEG23Tz1Y0rQ4OFjQUXiQzJZ8rGE5l7l9eStHKc/jqJxPeLPLi+6DHNfa+4nn0AMOrguc4bN+Aef10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751894120; c=relaxed/simple;
	bh=2dWgPe17PK5fdufSva/Q7JmuxJeb+/oVh1AHMVaqkak=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oa0NaIXMWKx+vcF61KbIljcNXNjNz69L3bp29fc+VEKLHrYsI3krAPWSnuTzBXL/lUbsXippESZfTmjW7JDgf0spxJdq/qgmB1oth8/j0uFZHW3J2sVoxi4ufhr7Yma3kjZlFY4cgPNjcSjAJghHGVLetPYRrSuAdE6raD+ZFi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4xlipVP; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4xlipVP"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-553bcf41440so3211433e87.3;
        Mon, 07 Jul 2025 06:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751894117; x=1752498917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gbPX0NE/xm0nQIylEPb1G6KJpxgsJepLGdVW149EGic=;
        b=j4xlipVPTeklMAyij2EkH7A0NCfmQDTgnjjsST+zv8S5ShWthNaNYf7IEanF2+z6aE
         OE3HnF2aJAg4UpUzz+yZINVE5gJ6Xj9u6PWcs1ZmkRJf+1fkY/hKuEAH+TOVnjhXWVjw
         7WyzyhbWpLSLPFAItOaRkl5H2kqEOnwdBe7PAVxkO4mS5IMaUQQiTbXwybecLiFhktCJ
         EMMO2oAwVxTsjMLMOJFVVXEcOmmep9JjnwncUIAAZQUHS0Ld/q3wnNzK2PGh7pjfFUZB
         q/v6tsY1FUZiecfcebngcZNfNhwYEFZZWgrEtk3P03TXgFXJxVAoZcC9Nenex1VxEPEe
         oiwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751894117; x=1752498917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbPX0NE/xm0nQIylEPb1G6KJpxgsJepLGdVW149EGic=;
        b=wjQXknY0tBJsWAzwNIHFJPMxo/2KZd+CJSYNYOrApiDx2vcL9BWeZMZY/Tu3XuT7a+
         zslBkUmMnQAiJ1IqU6qNjmp/R4Z51MLJ92Iqeqw1VoQFEDhtnygghcHH0Y097fq6TVZK
         RPuhjBIwCJkbW5PIehnInINej1cxW5o1mCEYqpYkrhrf64WUkYVd/1u8q95iVsPDKVvM
         CgLhYZtxZj68/zT7pxd3W3OK6SfPCCAlpfjD2Bsnwss+4QRhIRARxBoLhKVyngk7YBe8
         e/RTq+bdS9JQHaTBRZVbPtcXXn53NcppsO5AT94fhvRmpXyfhVoz/paZDho04xVJslex
         wWtA==
X-Forwarded-Encrypted: i=1; AJvYcCVfMc4/1TN53hL3XdR6eam+XnEoZsRrm6jxAxgmK8GeUcRGaG411dWpchI7Kn8VNGRj6p139k0GvwmLmSI=@vger.kernel.org, AJvYcCX95L5hWDEsfGDwKQboAcmdmVSKZWExvs6Aoj4J0xV4cEV9HcxDLKV45usjHmUPQ77N3oe3@vger.kernel.org
X-Gm-Message-State: AOJu0YxQUUFZYp7bj9eh5hXQivfcN194uYxpYU7Z+qm9nUD7xuppRfzf
	TCUwRpO8stG5R+YpB2t4TB4Ogg3BmRECMai4mql6WdFywk5/5U6bj2idmFRG4g==
X-Gm-Gg: ASbGnct9nHfcJbXnGZNJZXYWvoz/wTaR4eXhUtNtzTs6bONynbBHeD4wVQinSaBu9oc
	d+QtzDmRTgkYcUzMO5KOXpJn1aU27/QukmPbd/oyqQzfkkyTH/Nqa4gcSTYbZJb0UtKh+HOgiAr
	KxSZabXe2K3/UgxTG58y4BbsS26LXt4U8nzfd104Etm9i49brJ5yrF7DT/cd3tE5fpkr9ydrdcO
	U0lHeZI+1y43nbIgPQG69TuTiZzO0CG4ZQMjS81s6lzQNZ2DJcjp/UcwC90KqEvIOFd2Es2sHyC
	rm8SmZ92yuiMI+LwLXpRjay+4Dg/OGxgO0j4R1ZN9u5ONqcATtxNMTen8ZTbLy89vmAuEEQaxOK
	NDYcPDBTfZpg=
X-Google-Smtp-Source: AGHT+IFP+25N80hK9wedsBU2WB382/UhHmXyfAE1YhEjnQFs2oNEyyhujLqCT7wV/yUg8AdNcEHOtw==
X-Received: by 2002:a05:6512:2c05:b0:553:6583:8e6 with SMTP id 2adb3069b0e04-557e5532091mr1980003e87.15.1751894116472;
        Mon, 07 Jul 2025 06:15:16 -0700 (PDT)
Received: from pc636 (host-95-203-1-180.mobileonline.telia.com. [95.203.1.180])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556384a68f3sm1351686e87.144.2025.07.07.06.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 06:15:14 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 7 Jul 2025 15:15:12 +0200
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: Re: [PATCH v3 1/2] rcu: Enable rcu_normal_wake_from_gp on small
 systems
Message-ID: <aGvIYMBJsOpNx7-9@pc636>
References: <20250702145938.66459-1-urezki@gmail.com>
 <aGajO8rOu_GOnjrS@pc636>
 <ccca5cb2-0d41-4fe1-a4a5-4344b4116770@amd.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccca5cb2-0d41-4fe1-a4a5-4344b4116770@amd.com>

On Mon, Jul 07, 2025 at 09:19:03AM +0530, Neeraj Upadhyay wrote:
> 
> 
> On 7/3/2025 9:05 PM, Uladzislau Rezki wrote:
> > On Wed, Jul 02, 2025 at 04:59:36PM +0200, Uladzislau Rezki (Sony) wrote:
> >> Automatically enable the rcu_normal_wake_from_gp parameter on
> >> systems with a small number of CPUs. The activation threshold
> >> is set to 16 CPUs.
> >>
> >> This helps to reduce a latency of normal synchronize_rcu() API
> >> by waking up GP-waiters earlier and decoupling synchronize_rcu()
> >> callers from regular callback handling.
> >>
> >> A benchmark running 64 parallel jobs(system with 64 CPUs) invoking
> >> synchronize_rcu() demonstrates a notable latency reduction with the
> >> setting enabled.
> >>
> >> Latency distribution (microseconds):
> >>
> >> <default>
> >>  0      - 9999   : 1
> >>  10000  - 19999  : 4
> >>  20000  - 29999  : 399
> >>  30000  - 39999  : 3197
> >>  40000  - 49999  : 10428
> >>  50000  - 59999  : 17363
> >>  60000  - 69999  : 15529
> >>  70000  - 79999  : 9287
> >>  80000  - 89999  : 4249
> >>  90000  - 99999  : 1915
> >>  100000 - 109999 : 922
> >>  110000 - 119999 : 390
> >>  120000 - 129999 : 187
> >>  ...
> >> <default>
> >>
> >> <rcu_normal_wake_from_gp>
> >>  0      - 9999  : 1
> >>  10000  - 19999 : 234
> >>  20000  - 29999 : 6678
> >>  30000  - 39999 : 33463
> >>  40000  - 49999 : 20669
> >>  50000  - 59999 : 2766
> >>  60000  - 69999 : 183
> >>  ...
> >> <rcu_normal_wake_from_gp>
> >>
> >> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> >> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> >> ---
> >>  kernel/rcu/tree.c | 14 +++++++++++---
> >>  1 file changed, 11 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> >> index e8a4b720d7d2..b88ceb35cebd 100644
> >> --- a/kernel/rcu/tree.c
> >> +++ b/kernel/rcu/tree.c
> >> @@ -1625,8 +1625,10 @@ static void rcu_sr_put_wait_head(struct llist_node *node)
> >>  	atomic_set_release(&sr_wn->inuse, 0);
> >>  }
> >>  
> >> -/* Disabled by default. */
> >> -static int rcu_normal_wake_from_gp;
> >> +/* Enable rcu_normal_wake_from_gp automatically on small systems. */
> >> +#define WAKE_FROM_GP_CPU_THRESHOLD 16
> >> +
> >> +static int rcu_normal_wake_from_gp = -1;
> >>  module_param(rcu_normal_wake_from_gp, int, 0644);
> >>  static struct workqueue_struct *sync_wq;
> >>  
> >> @@ -3239,7 +3241,7 @@ static void synchronize_rcu_normal(void)
> >>  
> >>  	trace_rcu_sr_normal(rcu_state.name, &rs.head, TPS("request"));
> >>  
> >> -	if (!READ_ONCE(rcu_normal_wake_from_gp)) {
> >> +	if (READ_ONCE(rcu_normal_wake_from_gp) < 1) {
> >>  		wait_rcu_gp(call_rcu_hurry);
> >>  		goto trace_complete_out;
> >>  	}
> >> @@ -4843,6 +4845,12 @@ void __init rcu_init(void)
> >>  	sync_wq = alloc_workqueue("sync_wq", WQ_MEM_RECLAIM, 0);
> >>  	WARN_ON(!sync_wq);
> >>  
> >> +	/* Respect if explicitly disabled via a boot parameter. */
> >> +	if (rcu_normal_wake_from_gp < 0) {
> >> +		if (num_possible_cpus() <= WAKE_FROM_GP_CPU_THRESHOLD)
> >> +			rcu_normal_wake_from_gp = 1;
> >> +	}
> >> +
> >>  	/* Fill in default value for rcutree.qovld boot parameter. */
> >>  	/* -After- the rcu_node ->lock fields are initialized! */
> >>  	if (qovld < 0)
> >> -- 
> >> 2.39.5
> >>
> > Neeraj, are you planning to take this for next merge window?
> > 
> 
> Yes, I have queued v2 of these for testing here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/neeraj.upadhyay/linux-rcu.git/log/?h=dev.01.07.2025
> 
> Will include them in PR for next merge window.
> 
Thank you! I asked because i did not see both in our common RCU tree.

--
Uladzislau Rezki
