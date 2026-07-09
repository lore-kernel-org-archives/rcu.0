Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F91D3F8250;
	Thu,  9 Jul 2026 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605543; cv=none; b=bOWC8IaNvzKWqJ3lBDthBLJe9TXtrKk7x94Djwv9Z8OnNQfDLpodZyONmBtLCU7fuTLPtyAM+jl5h4ysdQ/KXy5M7N1q5OCpuSH7Pp+7pro2zaUfdNbibietAqPiwbgF5PEof6ZhP2e75quzqGYrDLl5L4lz8vSQxpucMr2u/fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605543; c=relaxed/simple;
	bh=qGkC14PdkfCQs6G05+kxkDa3hHroe0AY0po+XOyzU3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gj0T/TwvQKyyCxDnq0jS/gUJInzdf7ooSKASVkEP65SHwp5z//nXujTPWXwvKzctumJ4xVB4rY0GSCJyhg3vu3T7+jUb0NseUYyDBY9C7b/hTVmyYDIgiClewgf4OOme/fuWUHKNeuPknAs2olGEDPfUKf1PfyCjrn6KfTgecPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=heB6yluK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="heB6yluK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98E31F000E9;
	Thu,  9 Jul 2026 13:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783605542;
	bh=Bm6fq8XoYb0U7/vj2DxsGrztrYEANHIpzayH2bfRTLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=heB6yluKCo0d/x8jPohho8NZ1tlYzXqcQHvknyCynz+eJtOWKkST5HnZ4VjUjTs7D
	 +sbJM524OBZeTbFQ98cw37HocCWMcGwqPwUuwO6DiO+qFwipk+Z1IvaXwiOAAqXB6H
	 ldG27wN2q2LiGDOS6LjrWdHnrcGAEHz8msikcJg7by5aKN3NttkfIBLo5udFpEbdAF
	 As69QBNZTiHx+8MjLhZwqpqB/KK8lyi5h+aXFbl99W+liQPIT+QK4QYiC49xjxn+5b
	 BdiXxeIan34/ho99c6K6XL4JbO8b7KI4mQbbj7k7Bb1tHgBJSuswLPB5WjEPmvHTDh
	 Bg7Y1+mRAwnEg==
Date: Thu, 9 Jul 2026 15:58:59 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH v1 06/11] rcu: Enable RCU callbacks to benefit from
 expedited grace periods
Message-ID: <ak-pI2CefDoz0D0M@localhost.localdomain>
References: <20260624132356.516959-1-puranjay@kernel.org>
 <20260624132356.516959-7-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260624132356.516959-7-puranjay@kernel.org>

Le Wed, Jun 24, 2026 at 06:23:48AM -0700, Puranjay Mohan a écrit :
> Currently, RCU callbacks only track normal grace-period sequence
> numbers.  This means callbacks must wait for normal grace periods to
> complete even when expedited grace periods have already elapsed.

The changelog still misses the reason for this change. I had to read
the lwn article to understand that this matters under memory pressure
in order to release objects faster.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs
