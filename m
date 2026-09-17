Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F453CD8BF;
	Thu, 17 Sep 2026 18:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789670741; cv=none; b=Cz39GdhoVmCu//xZybCoknhIko7vE77ICjS6lvEPQn8tejKiaL4O7jiwQK4BvaLMmRx48kfcD471iWDOO5MVWiVCAm0pBpsYyMHdWRxjR80QSK67aCzexXV59WNDd/gIEXzenGoad+uB/Hyv/WMxUfggratY3mUvQQ4jcBfjWl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789670741; c=relaxed/simple;
	bh=dGPj631yJf05MB7oAsxBuAZXm3ahp193vFT2rP7+F8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdEo1M41tIse2zOGq2z8PK9Xp24WbO9eTiK8+QzOoTxF8gUPyNS4JwQHCh/vBPSJVfljMBmO2VXdELJNgAi88c+QhvW0Ex+frHZiMX9kktwQDY3tjlo4iYmT8+meowiv4GUMAqNTqQc1VyYLt8INDiDH+vAzMYA7P9jUOhJSh7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h33H9Gdu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h33H9Gdu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C4C1F00893;
	Thu, 17 Sep 2026 18:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789670740;
	bh=VUqmoZ9tkjprNUAzv5MpNYkWxkSqU7Rla2JQs5OrKPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h33H9GduZ2Nbb//sSFkLLwqVDqBIdeknn/eumej5e7rnzoQFxi4MlgOnM2Gt6j7GB
	 iE3tvUHRv+ixjLq+DWgWPyT7DoF/CYAC3R4euNtsJ2N4LHOUWTuAenMrDCqNT8k0zG
	 U59UbDrs8tfw88NjPBWxAmzoXD7fWC5AStfO6GkpqIyMxP60IaZf1VURFo7L1a2N31
	 CZ97fG48sVdVZAt67BzNGDjQ2uyRlnAdjFzsJJASWRSNkAFHDnymfoO1wKmIi3sYQ/
	 uiC5mOc8yyM/Z/8oOa/Nnm/1UaEfhLKvQNS2zEGERuhrZ7oxaz7OX2ScghU6oH5ZC+
	 c1PYnG1LmvA9g==
Date: Thu, 17 Sep 2026 20:45:36 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, x86@kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Andy Lutomirski <luto@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Juergen Gross <jgross@suse.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH RFC v3 03/13] rcu-tasks: Add a Tasks RCU implementation
 for reader-marked trampolines
Message-ID: <aqw1UNGO3cQxvCco@pavilion.home>
References: <edc7cca2-a5c5-455c-8969-ea05dbdb08f7@paulmck-laptop>
 <aqqONH8flTIpOUqT@localhost.localdomain>
 <91687748-0781-4133-baed-43cf82f35ff5@paulmck-laptop>
 <aqqpRoTfywUuTgoC@localhost.localdomain>
 <aqqsAUVV8a1yrQzX@localhost.localdomain>
 <6afb0afe-e7b8-46b4-9fea-2c7cf4791044@paulmck-laptop>
 <aqq0cwvRDsorGwgc@localhost.localdomain>
 <8b73e1b3-0580-4ba9-b2e0-6363e429808d@paulmck-laptop>
 <aqvZwfUVsiEI7q7y@localhost.localdomain>
 <8fea176a-0ca0-4a70-8cf9-8240a22359e4@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8fea176a-0ca0-4a70-8cf9-8240a22359e4@paulmck-laptop>

Le Thu, Sep 17, 2026 at 08:40:10AM -0700, Paul E. McKenney a écrit :
> > > Trampolines that transfer control to tracing code could supply the needed
> > > cleanup call.  But last I checked, there were trampolines that transferred
> > > directly back to the original code, with no opportunity for cleaning up.
> > > 
> > > Or am I still missing a trick here?
> > 
> > You're right. So we'll indeed need to reuse the deferred qs points here.
> 
> Except this is getting a bit involved.
> 
> Don't get me wrong, if Josef is happy to take this on, far be it from me
> to stand in his way.  But if not, we should be willing to treat this
> optimization as a follow-on effort, whether by Josef or someone else.

Sure, I guess I can try the follow-on, especially if it leads to removing
all this RCU tasks black magic.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs
