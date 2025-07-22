Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51341F16B;
	Tue, 22 Jul 2025 22:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753224462; cv=none; b=A54i4Lz2qyJ6NPWwbf8sCeTONhv0/8UglEVIhUMhTmDgb5vDTrc6zDR+I6T471g7K6wHOvWaAZ+f73iapvrdqeMuf8QtAIjp6c/CGAax4jgiBJXkWwZDbJ27mmUQjElawFMmF7yzECs6N5a2IWP6V+cY/FEfvvNhw610y6teNck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753224462; c=relaxed/simple;
	bh=EoiyKUGwzUZrIFfFpBNeyjWZsXdD7GTQICDsD6VdHGU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a71cXf4dR43orCyGGrWKaeZXDq+CAeyJ5PlI7uFYpP7patt11DRrpi6gRk0N+FhpMgPhx4omj8Q6va6yl94zQuq3DXTrLGGXHpYFJ6c/irUu9srPqpf883ve6K8dp0Sz7J+41aEc77zvbBEI9nIb3MPmx90ODyrOXiJK3Opqhiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 7AFE51A0368;
	Tue, 22 Jul 2025 22:47:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 899E617;
	Tue, 22 Jul 2025 22:47:37 +0000 (UTC)
Date: Tue, 22 Jul 2025 18:47:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Subject: Re: [PATCH v3 2/4] srcu: Add srcu_read_lock_fast_notrace() and
 srcu_read_unlock_fast_notrace()
Message-ID: <20250722184736.13a0e879@gandalf.local.home>
In-Reply-To: <4ac56245-3185-414d-9ee1-2c4b4c0a9d5b@paulmck-laptop>
References: <7387f0c2-75bc-420d-aa7e-3a9ac72d369c@paulmck-laptop>
	<20250721162433.10454-2-paulmck@kernel.org>
	<20250722221100.GA377047@joelbox2>
	<4ac56245-3185-414d-9ee1-2c4b4c0a9d5b@paulmck-laptop>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 3e7dn8tbtphsub7f43ixdetyg1o4hjwf
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 899E617
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19JdSHX+WfFntKaXA9HnsVIVUv8qmc9gf0=
X-HE-Tag: 1753224457-90458
X-HE-Meta: U2FsdGVkX19eLl9Lk2E7eE7eJ9SkgmX3lXH5G5h338IYMZjZgOLP5YKjWvAjLOErRkGclRbvMZxUwNNuWrsePsi+3Xa9T7Boy3BL/OTQjx4YXxunsOxUK2kfkiMrnTJtlHXb4+lR7A2CXYB0DGt8TSTi3gx3wFKV9dExAau7loJ9X7QCp8gyTvjY7K3pBkfUdiunUFoly8s/dzFK/onJyMoqjCyjhN/ygMt/DNPRBlg+0hgOxmOqPVnSMJpCHNdmpYEISyCECkKbF73LaeNrp1NCTCul+7FtcEf+d12DQDzN/EevXHNCxyKJcCnaSzmp/FLHU2ft3R/3sLZGhkLmDN9RyUzG4xGO

On Tue, 22 Jul 2025 15:34:52 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> > > +static inline struct srcu_ctr __percpu *srcu_read_lock_fast_notrace(struct srcu_struct *ssp)
> > > +	__acquires(ssp)  
> > 
> > Should these also be marked with 'notrace' attribute?
> > 
> > I am not sure what the precedent is, I do see a few examples of 'notrace' and
> > 'inline' in the same function signature though.  
> 
> Heh!!!
> 
> There are six instance of static-inline notrace functions, and eight
> instances of static-inline non-notrace functions whose names contain
> "_notrace", not counting the srcu_read_lock_fast_notrace() and
> srcu_read_unlock_fast() functions currently under review.
> 
> My guess is that I should add "notrace" to handle the possible case
> where the compiler declines to inline this function.  I will do this
> on the next rebase unless I hear otherwise.
> 
> Steven, Mathieu, thoughts?

If you add "__always_inline" then it will include "notrace" as inlined
functions are not traced. But we have removed "notrace" from the generic
"inline" a while ago. If the compiler decides to ignore an "inline" it
*will* be traced.

We probably should fix any "_notrace" functions that are not
"__always_inline" and do not have "notrace".

-- Steve
