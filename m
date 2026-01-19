Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9871320296E;
	Mon, 19 Jan 2026 14:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768834786; cv=none; b=jAWFhGDYM3ELpUk11iNh/dOb9wL3RfrNOFiSoUwLVDeV3h0Hr+kPKnKyEa/y3wEm1twsXUkdyLdz8qT74Pv6cDDXKmhDUcdNiowjDbBUBGhHCs6Dz5+kVvkZtSGqN5+gfhcGegOAuq2zayIbXqnBgcz6S06I+P4aZG5lLiiKD2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768834786; c=relaxed/simple;
	bh=YOVbbBNyxPeKtCs6MGZ9TkkE4qQ5kDG9aPGOl3YSeNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7rv/8hJ1MWFZmI24l4xbV8Mce0WfyWXQfu7o0dstqRDv2mWQ04qrP8L9pJ7aZ4V2Wj0EAoPXuVrwFH8BZpAKxh4VcY5Ua2qjO/ORKKZYXK4h6tLQTI4IRNss945E8cBOQVRrghsfnDI9aasKf5VQTr+izeAOD7oE6VoBQKYGxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=po78X6cP; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="po78X6cP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hfrMJcjhCPwaXOiFvFfjK0cyGb+DpxWrsQjShWS+Z7U=; b=po78X6cPlo95nGC3rI+a4Z57uo
	OwH1GUNirgI2P8sr3VY/4QwPApvOyRJvZTtOKtpKHAcrRkjzpMeLwnBoDdkJrruI1bFCd0Y6EWMI8
	KuXFRK3QfP4OVJBhpxgX9MVGfm52EbPT1WvElxy4yxMwGuz9Gxw6Nna2r7eAf8p/fGFEUrmGAMghO
	GUdsdMK1ZQ4OTIFyKjEsRjMfK3c03RX6B61dfXr+T2PE3n4mLKKI/trsNUSVXQs+cw3cUy7mZgIQ2
	qvXzlWc0iifu5Cur9XbijP3Fi+HEkrNMJw32gMaDZ36CiXWQBJ2yHrbQSAG37ouxhHkmtpj4tPzEU
	q6G8D2+w==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhqjD-0000000CM5g-3eQq;
	Mon, 19 Jan 2026 14:59:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F07403006CD; Mon, 19 Jan 2026 15:59:38 +0100 (CET)
Date: Mon, 19 Jan 2026 15:59:38 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
	Vishal Chourasia <vishalc@linux.ibm.com>, boqun.feng@gmail.com,
	frederic@kernel.org, josh@joshtriplett.org,
	linux-kernel@vger.kernel.org, neeraj.upadhyay@kernel.org,
	paulmck@kernel.org, rcu@vger.kernel.org, rostedt@goodmis.org,
	srikar@linux.ibm.com, tglx@linutronix.de, urezki@gmail.com,
	samir@linux.ibm.com
Subject: Re: [PATCH] cpuhp: Expedite synchronize_rcu during SMT switch
Message-ID: <20260119145938.GJ831050@noisy.programming.kicks-ass.net>
References: <20260119141118.GF830229@noisy.programming.kicks-ass.net>
 <DS0PR12MB6486E6599B99D08C5E46EC06A388A@DS0PR12MB6486.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR12MB6486E6599B99D08C5E46EC06A388A@DS0PR12MB6486.namprd12.prod.outlook.com>

On Mon, Jan 19, 2026 at 09:45:48AM -0500, Joel Fernandes wrote:
> On Sun, Jan 19, 2026 at 03:11:18PM +0100, Peter Zijlstra wrote:
> > By holding an extra rcu_sync reference, the percpu rwsem is kept into
> > the the slow path, avoiding the rcu-sync on down_write(), which was very
> > prevalent per this:
> >
> >   https://lkml.kernel.org/r/aWU9HRcs4ghazIRg@linux.ibm.com
> 
> Makes sense, though I wonder if we should have a separate percpu-rwsem API
> for this rather than directly accessing the lock-internal rcu_sync state?
> Other future percpu_rw_semaphore users may benefit as well.

Yeah, perhaps. There is one other user, the above makes two.

kernel/cgroup/cgroup.c:         rcu_sync_enter(&cgroup_threadgroup_rwsem.rss);

