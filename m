Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D54D392C34;
	Wed, 18 Mar 2026 10:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773831460; cv=none; b=FzWSQ1U4fxWh2y9YeGZR5RlBSfzl5GhaexzwSji3/xMhisJiqaBsxvl6/ZtFsY2labUnznavuwFVG+1RwO1oB6qjb92HP6u2Q6c5qJ+7FtYEhJf9htTm8OiSO0R/pTBYWtNdbahP075VwL4rcTVm+YhvwbYiEvDgGZ+Xm2iwHt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773831460; c=relaxed/simple;
	bh=HYgsxr6I03p59fJyRKL0k1Vjn3kfjw3xLfUOCvw4RY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2Le1bdOwONHIjMmB8/1yZn+MRHjeNZnCefTJ47LfKgwZJRw6t8/rWcKGTcj8CJT4EYESMl/K7L+Pi7zYZCDFhHsk/uqbKnuSV29v70rpsnjCVuo3NLm5VyNVpQ+XFi6xxN1dAxwSNUSMl9fB94B2UtvZwt0rucMiRiaqzAmmsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdfB1pvK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdfB1pvK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8C5C19424;
	Wed, 18 Mar 2026 10:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773831459;
	bh=HYgsxr6I03p59fJyRKL0k1Vjn3kfjw3xLfUOCvw4RY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jdfB1pvKydtr3v9/o04w2IRjbP2GlbFq49Tk0vqfPf5CpcfUi03ehDrfwFdt8x7GE
	 EIzAqovnbbNWjI0PGTdjKHelkGi8t9gCY/iElDeJ39P4ewxq5XVnxiICL3dl/ttU+L
	 /ujsfoETG9dhvMHJcpOjnQXpF4zI/Lbmrw7VgpUvmKjVejkrfWLmxAG35dYiqb7VF8
	 liXGHX1wsji6WTrLckQuIXho/KmZ0Ulx3Di7zwI4ZibmBAJDKmrpG472dK7fKEnOVE
	 vFGOQibQGfxNhsUBn7T4Ds6gezHnI8E85fsy+PDiwqyHB8z3/2g8Wim1mmywegMWUR
	 PFLfMkdWK+kbw==
Date: Wed, 18 Mar 2026 11:57:36 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, rcu@vger.kernel.org
Subject: Re: [PATCH -next v1 13/16] rcu-tasks: Remove unnecessary
 smp_store_release() in cblist_init_generic()
Message-ID: <abqFIAKnfuvZLoZW@localhost.localdomain>
References: <20260317212217.1527644-1-joelagnelf@nvidia.com>
 <20260317212217.1527644-14-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260317212217.1527644-14-joelagnelf@nvidia.com>

Le Tue, Mar 17, 2026 at 05:22:14PM -0400, Joel Fernandes a écrit :
> From: Zqiang <qiang.zhang@linux.dev>
> 
> The cblist_init_generic() is executed during the CPU early boot
> phase due to commit:30ef09635b9e ("rcu-tasks: Initialize callback
> lists at rcu_init() time"), at this time, only one boot CPU is
> online and the irq is disabled. this commit therefore use routine
> assignment replace of smp_store_release() and WRITE_ONCE() in the
> cblist_init_generic().
> 
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs
