Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9EE37D13F
	for <rcu@vger.kernel.org>; Thu,  5 Mar 2026 10:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772708361; cv=none; b=Maen58eE/abdn38LmBvGi1xSKa6dY1i1XJwcM6ONjNjq6tfQNX5M9nitIcTQnU70dXcNyeNJ/p7palmZeaBuHTmbdcYLX1vdTnrfzBIt78Se5udM91jkbvCnSpl3sJidTFFu0ze1s7kE1pFO38Wd6PfmcP+i+e9/kfWaA2Tq7ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772708361; c=relaxed/simple;
	bh=QQEMr4WAaY5BTcULdsAns7R94VawBnIxsLQI75/5CDY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0u+zEihwywF18t2xgg3l7fQ8vC3cPyNf+YF+VFQPzK3xd0xmUtHpJOWoH32lasVD1xBftk+lqsqh9mp4kaCiYavb6MBNhX6C/KqzXT/G+RhbVCGhAlHE1OXOHsHuhukznu0iptDPUkrBL8E8Dg507/UPPiKPMP9rZUqM1bRMec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hV9u/Nbd; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hV9u/Nbd"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-389ff6e5885so68289211fa.0
        for <rcu@vger.kernel.org>; Thu, 05 Mar 2026 02:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772708358; x=1773313158; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vgF0XfNL/g8FZd2my4PgMi3Ls0C0pto1abmXR3g8WOg=;
        b=hV9u/NbdI5DcyvZs2W9R8RieGS0i+uaCS3HFJKIxxKM7Y5ZK4g5YSTF2KfijKHPYk1
         dObafLDkGQS63/TaNrFQ0e0D3WTYz24aujrZI2dt04ZMDdRnnAtRK3Gin4rd9Kty2XRq
         lHUFoORWQNchOuQCYrvUWGEZLTdUY3RojmrN/rBw06ekiABfneCJcg57WqWXNTvdK6nm
         pX2hxhGq3jQYXsDRwrfvJ7H3weopNp5x2r/dmrLBQcDjXC3wPw4wQPY8iywiPzy0mpEA
         FMt3Vp7PsdKq0rDumqyITirtrWxeFu/+VCdtMXcbMeUboGWrntI0tqs6fToDKnZU5CM8
         +fog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772708358; x=1773313158;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vgF0XfNL/g8FZd2my4PgMi3Ls0C0pto1abmXR3g8WOg=;
        b=IYBOEwdO8Ob2oBbgZLZHPfkVOKmh6ex9EvjVjCsnDOvadepolt8bcSp69KWNsAKAMo
         eGDoJy0kqyAiRyJWHh+VXu6LPhnnWUS79iSNfxuGl/2Wp7PzBPEjr/rjCKbMWTvadqDt
         RfqxzIaNN62A4jaYPaYzORnpyT6DohebNHGnJNXbo0ZS/R8T5QNTaJOOxAds5YyPtIbM
         qAKC0LgCd8MTzQUCs+0aL3iHXnggAaQsEUbBJ1+0qoJUuVbryrF9RGVVr+5/FNWAOPeu
         MjJynuJDNFjnSg4u1x1C7L+waY566ElIhgTPwkw0oclOnplFoe4yMwgbY6eopJKJRjKS
         r+eg==
X-Forwarded-Encrypted: i=1; AJvYcCXHwS6rexg9tUs9CywKg3/BO6IwGDAsITRxAkYI3ueOcOWIURK18wNhHdwKMj64uBQBijA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFgKgb7+ZcQmlekXmMy6MbyYhh7hIGyICW7QgDHPxtK/H/87CJ
	L3ejd9GncItiZCcBHN3UqMo3J01B1ODaKUiYyIrNWEwevzSll51n1jRf
X-Gm-Gg: ATEYQzzib8dOXInmvZgMuqKUItaLBB2KxxMP7QjKamGKLAnknj3O2TC8FtWc13hczLK
	Wr5Wz3KIU/E+XQS1dyPT9KopvX4QUmWuAukyfps2qSRt0lzg0/3G4eRk07yuK9qQFS6MFcy4LJB
	FBF/hS3U6xNuRosI1D3pRz1ZogSGNqITz52UQOxiGMjAsPWFv2aa0/GpcVTwWlTjdujG9CvGysC
	UNAyvgpAiEM3aKxV+5AKzFdXAEOQuQamUQ4whSh50qSbln/sZkt3g9/usIwgFMe32cEHJcJKfYW
	OXS56tCBaGLRcVdaxb6K3uC/aS0B86MgxODF/8mzWZmUUOuHKAx/XvL13fHSVjX4N3zrHW1REF+
	wVl+8PJ+vbDKhB1OJWMamh4pIYhFXQplUXogMdkNFZiOWC9JCDRJDC7u7x0R7f0lv
X-Received: by 2002:a05:6512:3d9f:b0:5a1:3561:c6b0 with SMTP id 2adb3069b0e04-5a13561c761mr352992e87.7.1772708357898;
        Thu, 05 Mar 2026 02:59:17 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a12e91422dsm779437e87.28.2026.03.05.02.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 02:59:17 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Thu, 5 Mar 2026 11:59:15 +0100
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	"Paul E.McKenney" <paulmck@kernel.org>,
	Vishal Chourasia <vishalc@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Samir M <samir@linux.ibm.com>
Subject: Re: [PATCH v2] rcu: Latch normal synchronize_rcu() path on flood
Message-ID: <aaliA7sc4Nnu_i_C@milan>
References: <20260302100404.2624503-1-urezki@gmail.com>
 <14e954e4-cfa6-4069-a25f-ccb444d17535@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14e954e4-cfa6-4069-a25f-ccb444d17535@nvidia.com>

On Tue, Mar 03, 2026 at 03:45:58PM -0500, Joel Fernandes wrote:
> On Mon, 02 Mar 2026 11:04:04 +0100, Uladzislau Rezki (Sony) wrote:
> 
> >  * The latch is cleared only when the pending requests are fully
> >    drained(nr == 0);
> 
> > +static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
> > +{
> > +	long nr;
> > +
> > +	llist_add((struct llist_node *) &rs->head, &rcu_state.srs_next);
> > +	nr = atomic_long_inc_return(&rcu_sr_normal_count);
> > +
> > +	/* Latch: only when flooded and if unlatched. */
> > +	if (nr >= RCU_SR_NORMAL_LATCH_THR)
> > +		(void)atomic_cmpxchg(&rcu_sr_normal_latched, 0, 1);
> > +}
> 
> I think there is a stuck-latch race here. Once llist_add() places the
> entry in srs_next, the GP kthread can pick it up and fire
> rcu_sr_normal_complete() before the latching cmpxchg runs. If the last
> in-flight completion drains count to zero in that window, the unlatch
> cmpxchg(latched, 1, 0) fails (latched is still 0 at that moment), and
> then the latching cmpxchg(latched, 0, 1) fires anyway — with count=0:
> 
>   CPU 0 (add_req, count just hit 64)       GP kthread
>   ----------------------------------       ----------
>   llist_add()    <-- entry now in srs_next
>   inc_return()   --> nr = 64
>   [preempted]
>                                             rcu_sr_normal_complete() x64:
>                                               dec_return -> count: 64..1..0
>                                               count==0:
>                                               cmpxchg(latched, 1, 0)
>                                                 --> FAILS (latched still 0)
>   [resumes]
>   cmpxchg(latched, 0, 1) --> latched = 1
> 
>   Final state: count=0, latched=1  -->  STUCK LATCH
> 
> All subsequent synchronize_rcu() callers see latched==1 and take the
> fallback path (not counted). With no new SR-normal callers,
> rcu_sr_normal_complete() is never reached again, so the unlatch
> cmpxchg(latched, 1, 0) never fires. The latch is permanently stuck.
> 
> This requires preemption for a full GP duration between llist_add() and
> the cmpxchg, which is probably more likely on PREEMPT_RT or heavily loaded
> systems.
> 
> The fix: move the cmpxchg *before* llist_add(), so the entry is not
> visible to the GP kthread until after the latch is already set.
> 
> That should fix it, thoughts?
> 
Yes and thank you!

We can improve it even more by removing atomic_cmpxchg() in
the rcu_sr_normal_add_req() function, because only one context
sees the (nr == RCU_SR_NORMAL_LATCH_THR) condition:

<snip>
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 86dc88a70fd0..72b340940e11 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1640,7 +1640,7 @@ static struct workqueue_struct *sync_wq;
 
 /* Number of in-flight synchronize_rcu() calls queued on srs_next. */
 static atomic_long_t rcu_sr_normal_count;
-static atomic_t rcu_sr_normal_latched;
+static int rcu_sr_normal_latched; /* 0/1 */
 
 static void rcu_sr_normal_complete(struct llist_node *node)
 {
@@ -1662,7 +1662,7 @@ static void rcu_sr_normal_complete(struct llist_node *node)
 	 * drained and if it has been latched.
 	 */
 	if (nr == 0)
-		(void)atomic_cmpxchg(&rcu_sr_normal_latched, 1, 0);
+		(void)cmpxchg(&rcu_sr_normal_latched, 1, 0);
 }
 
 static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
@@ -1808,14 +1808,22 @@ static bool rcu_sr_normal_gp_init(void)
 
 static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
 {
-	long nr;
+	/*
+	 * Increment before publish to avoid a complete
+	 * vs enqueue race on latch.
+	 */
+	long nr = atomic_long_inc_return(&rcu_sr_normal_count);
 
-	llist_add((struct llist_node *) &rs->head, &rcu_state.srs_next);
-	nr = atomic_long_inc_return(&rcu_sr_normal_count);
+	/*
+	 * Latch on threshold crossing. (nr == RCU_SR_NORMAL_LATCH_THR)
+	 * can be true only for one context, avoiding contention on the
+	 * write path.
+	 */
+	if (nr == RCU_SR_NORMAL_LATCH_THR)
+		WRITE_ONCE(rcu_sr_normal_latched, 1);
 
-	/* Latch: only when flooded and if unlatched. */
-	if (nr >= RCU_SR_NORMAL_LATCH_THR)
-		(void)atomic_cmpxchg(&rcu_sr_normal_latched, 0, 1);
+	/* Publish for the GP kthread/worker. */
+	llist_add((struct llist_node *) &rs->head, &rcu_state.srs_next);
 }
 
 /*
@@ -3302,7 +3310,7 @@ static void synchronize_rcu_normal(void)
 	trace_rcu_sr_normal(rcu_state.name, &rs.head, TPS("request"));
 
 	if (READ_ONCE(rcu_normal_wake_from_gp) < 1 ||
-			atomic_read(&rcu_sr_normal_latched)) {
+			READ_ONCE(rcu_sr_normal_latched)) {
 		wait_rcu_gp(call_rcu_hurry);
 		goto trace_complete_out;
 	}
<snip>

--
Uladzislau Rezki
