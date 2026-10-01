Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710A8318EC5;
	Thu,  1 Oct 2026 13:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790861040; cv=none; b=JBpmqXf+KCS1i3a1bccwpthMph3M+TYDWIi3vcy4IQGla/ps5Bhw9BJcZMwJ2VEWz/M5HKOMJrjwoiN+ciQJKFYe7YkoyaB5dYO2V54IPaK+6jlwHtBIDSajrioCtJg884FY6algOrknSWiwn6nW6+HU/xRLV8Pf3uzGLQKK3R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790861040; c=relaxed/simple;
	bh=wDElpy/TGiRJSn/ziLR4CYi/go52QvZc+rz0PEQ7FBA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cuL+A0+XD3JTbZpdTDAJd8B6oAGP+JRx7jBr7P+VNg9AWlNmsmBio/nJgSs0MfGr15mt6sgN/O7KdVBGIxf+PzzMm/Qkw5a6ulNm15w5kOYi3on9+hFov/yotpt8b/8KARWHMvXri8eH8sGlFcfBYFWv9hNvOGBF2RIQBOVEIl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXYfjsEt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXYfjsEt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA95E1F000FF;
	Thu,  1 Oct 2026 13:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790861039;
	bh=DXB7tQcfmFfnugtQtf2FqJSIg4yqfN74RxF+rT3OIJ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KXYfjsEtmBrjOHOpmGcZsAOnEve26Cv9qvbg/YdeO4N92M7jmsbdZHAQsV+evXOLC
	 9/d9FILtp4cVeZM2Mgv+dKbzN5EsCPootQDurWLu3KDuC2VI50uhLA0bNX/S3INOI7
	 Hu/kUs7lyr9lgJeHJ8+NfkGx9nD/pjgrwzZclVw4J9BwfBNSe+KFf7RI/PEWJikDak
	 /S0yPrr7v6Tv5p0DBpjeOQ8luEk04CDL8AvlFy2mQEqDgamJh1dl6HR9Pab08V4w20
	 0CQLqE9ddLyPuDbW8lugUHOetzvCo2TIgA8hhbfT7AUNqB0GO+Kesc0MJp9lNvIOk8
	 kTbziUHvX2BrQ==
Date: Thu, 1 Oct 2026 13:23:49 +0000
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, Frederic Weisbecker
 <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josef Bacik
 <josef@toxicpanda.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH] fprobe: Use guard(rcu_sched_notrace) and check
 rcu_is_watching()
Message-ID: <20261001132349.472186a7@mhiramat99.roam.internal>
In-Reply-To: <20260930160325.3f2621ea@fedora>
References: <179064115227.394389.16910234241400391996.stgit@devnote2>
	<20260930160325.3f2621ea@fedora>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Sep 2026 16:03:25 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 29 Sep 2026 09:19:12 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > @@ -329,16 +333,14 @@ static void fprobe_ftrace_entry(unsigned long
> > ip, unsigned long parent_ip, struct fprobe *fp;
> >  	int bit;
> >  
> > +	if (!rcu_is_watching())
> > +		return;
> > +  
> 
> I'm thinking these should really be:
> 
> 	if (WARN_ON_ONCE(!rcu_is_watching()))
> 		return;

Hmm, is this for warning users to notice it is out of supported path?

If CONFIG_ARCH_WANTS_NO_INSTR=n, we will not prohibit user to set ftrace
avoiding the function where the RCU is not watching. So maybe it is hit
by user's operation.

Thank you,

> 
> -- Steve
> 



-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
