Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D12E259CAF;
	Mon, 12 Jan 2026 14:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768227843; cv=none; b=UiZYmwp7YJ9ymprXwOoxljeCdSwjNMTy1nTYvkHEzoM7fcJuiQrQEqs5CrTIO6APDWy61HQI205uaZnP3c9H0t5ntJs5hqIg8ckFygORrD+c6d4ux5rccTRb8TC6KHbVdRDL7gL54NyMP1RvPWhUI05XP7TlBHGG/CdA4BH0O4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768227843; c=relaxed/simple;
	bh=HNdL+nGLwCEwK3Vg7glHFzqIpfRLs1xwzlutoHSdLxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/cGzlGxcEeG/MDWTPNhmkUZnIUHyAimdWVr/Wv0P9aabdWatQYgwypFhix1QYeCQWbb3EByJrUPWMjcim5DGUrKhRKsTGk05g6EDaIbsMKFd+RRcUHpZs1I7dnLnDbwEwuZzYIwtbAiEKJw8LYMzSFbohR0QuJ8YoYDK6RAitE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KnUG7NVP; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KnUG7NVP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=CT8YjIiMn12YztEDLHejimpZz4enkn+3E/IVFfZ065E=; b=KnUG7NVPVQPC35vJQxUa78azzC
	LXOGez/LFKR7Do+B2ad2c3kmb5cjZ2y2/o62rd41IAQUHsmTGZhwzH9+FlSuwyIdJrDomeYefwL2k
	Wd0DIZ+rqVjflodkXAtPAEW0Kuh6w3WjZ30XqJ6awecFVTrhFQaO0WFMVWcw0X6sQadYkmBAGgsT/
	L6N1kKJ8SatiuVkCbr+PI1cYibHfo+1X1LGH+6PzPdK5/SjJwOKen2Xj7yRXY2ThgG9mTf01DTWVx
	Wrt+Lp43cbVU3hw6zHNb4ny0Vs4ZSOtgiIyBGuGMDDQGmf67WewZyHPB5roXvqP4azuLoSCeS1yEa
	KATPWnvg==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfIpk-00000000sKM-2MKD;
	Mon, 12 Jan 2026 14:23:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1345F302D3E; Mon, 12 Jan 2026 15:23:51 +0100 (CET)
Date: Mon, 12 Jan 2026 15:23:50 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Vishal Chourasia <vishalc@linux.ibm.com>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>,
	"frederic@kernel.org" <frederic@kernel.org>,
	"neeraj.upadhyay@kernel.org" <neeraj.upadhyay@kernel.org>,
	"josh@joshtriplett.org" <josh@joshtriplett.org>,
	"boqun.feng@gmail.com" <boqun.feng@gmail.com>,
	"urezki@gmail.com" <urezki@gmail.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"sshegde@linux.ibm.com" <sshegde@linux.ibm.com>,
	"srikar@linux.ibm.com" <srikar@linux.ibm.com>
Subject: Re: [PATCH] cpuhp: Expedite synchronize_rcu during CPU hotplug
 operations
Message-ID: <20260112142350.GM830755@noisy.programming.kicks-ass.net>
References: <20260112094332.66006-2-vishalc@linux.ibm.com>
 <1654BF46-EB82-46C0-B03D-848C22CFAB4F@nvidia.com>
 <804E7B47-F515-4592-B12E-84AD251EB07D@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <804E7B47-F515-4592-B12E-84AD251EB07D@nvidia.com>

On Mon, Jan 12, 2026 at 02:20:44PM +0000, Joel Fernandes wrote:
> 
> 
> > On Jan 12, 2026, at 9:03 AM, Joel Fernandes <joelagnelf@nvidia.com> wrote:
> > 
> > ﻿
> > 
> >> On Jan 12, 2026, at 4:44 AM, Vishal Chourasia <vishalc@linux.ibm.com> wrote:
> >> 
> >> ﻿Bulk CPU hotplug operations—such as switching SMT modes across all
> >> cores—require hotplugging multiple CPUs in rapid succession. On large
> >> systems, this process takes significant time, increasing as the number
> >> of CPUs grows, leading to substantial delays on high-core-count
> >> machines. Analysis [1] reveals that the majority of this time is spent
> >> waiting for synchronize_rcu().
> >> 
> >> Expedite synchronize_rcu() during the hotplug path to accelerate the
> >> operation. Since CPU hotplug is a user-initiated administrative task,
> >> it should complete as quickly as possible.
> > 
> > When does the user initiate this in your system?
> > 
> > Hotplug should not be happening that often to begin with, it is a slow path that
> > depends on the disruptive stop-machine mechanism.
> > 
> >> 
> >> Performance data on a PPC64 system with 400 CPUs:
> >> 
> >> + ppc64_cpu --smt=1 (SMT8 to SMT1)
> >> Before: real 1m14.792s
> >> After:  real 0m03.205s  # ~23x improvement
> >> 
> >> + ppc64_cpu --smt=8 (SMT1 to SMT8)
> >> Before: real 2m27.695s
> >> After:  real 0m02.510s  # ~58x improvement
> > 
> > This does look compelling but, Could you provide more information about how this was tested - what does the ppc binary do (how many hot plugs , how does the performance change with cycle count etc)?
> > 
> > Can you also run rcutorture testing? Some of the scenarios like TREE03 stress hotplug.
> 
> Also, why not just use the expedite api at the callsite that is slow
> than blanket expediting everything between hotplug lock and unlock.
> That is more specific fix than this fix which applies more broadly to
> all operations. It appears the report you provided does provide the
> culprit callsite.

Because hotplug is not a fast path; there is no expectation of
performance here.

