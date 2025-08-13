Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0970F2EAB93;
	Wed, 13 Aug 2025 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755093408; cv=none; b=nYvqQcHfPYQW1ZgIyWvcSCGSFV+ko53qi+QyBKNkouVyFFj/wXSN8JmAqwTSKmgiGFr8SsyjQnzGhRwSzPivBGYcHceGcVl+679MuQq/77xs1JhA6g17BXHHDkkSgUhmSnA/UAk1cKpRvcfPl8LdJll0AxuWEz6blz+/eyxPq6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755093408; c=relaxed/simple;
	bh=gIt4wTImh/l3IDHeafkDLD9teCM7tyU5c+ZlMd4aQ/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXQtXC4+wS3IKY09XqwKZobyhBwrLw8cEvFHmOz57kFYiHdM6Ae2J0BIluKLAxOBWUZ59e5LhP06g7e44OzkHmKfU9wVe7jSa8qFcoZduA+nl4d94Vucd0huSuDtHROgJzLVft9A2jb5AelyuigNj6WzWhdy1HVz7sH+tNsMZJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYg7Y5tY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYg7Y5tY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160A7C4CEF6;
	Wed, 13 Aug 2025 13:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755093406;
	bh=gIt4wTImh/l3IDHeafkDLD9teCM7tyU5c+ZlMd4aQ/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PYg7Y5tYS8bxCUIEypFDl5W8/CiRSdrwpOqka5NfearAhT1gBEWt5jllhzQWTLV96
	 5PfixQHaiZtO1F0M7girUXngYNfJpaxaVL3nXFp1V6YOHVhx5ZSIDFTx6MG8cfjFMY
	 A0X1bu7NVetbXD1Jp1Yl1Fo1VHHWbwp5xSUnoiXOc388y+Re3hdU6DrxqKFAIbyucz
	 UKgDFkL+ptY3sDEi4/D/8uYuNPc7b063U3oCJDcpE19XGUmj0+Ae5hEQuk2W+YrSYz
	 LBIx8iqjvFC4koIRs1usYCWEdRFqnpvXiKKI5Ri8aNEtukbJqBWDUPIfEFmcppgJ8G
	 Qv8WiIQf+wfCQ==
Date: Wed, 13 Aug 2025 19:25:49 +0530
From: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
To: Oliver Sang <oliver.sang@intel.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Xiongfeng Wang <wangxiongfeng2@huawei.com>,
	Qi Xi <xiqi2@huawei.com>, "Paul E. McKenney" <paulmck@kernel.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	rcu@vger.kernel.org
Subject: Re: [linus:master] [rcu]  b41642c877: BUG:kernel_hang_in_boot_stage
Message-ID: <20250813135549.GA3156@neeraj.linux>
References: <202508071303.c1134cce-lkp@intel.com>
 <aJY1DsIUQxzq1U1Q@localhost.localdomain>
 <20250813044024.GA2872@neeraj.linux>
 <aJyWmUdR0LzIiSai@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJyWmUdR0LzIiSai@xsang-OptiPlex-9020>

On Wed, Aug 13, 2025 at 09:43:53PM +0800, Oliver Sang wrote:
> hi, Neeraj,
> 
> On Wed, Aug 13, 2025 at 10:10:24AM +0530, Neeraj Upadhyay wrote:
> > Hi kernel test robot,
> > 
> > > #syz test
> 
> sorry, we are not syz bot :) didn't capture this.
> 

Ah ok!

> [...]
> 
> > > Fixes: b41642c87716 ("rcu: Fix rcu_read_unlock() deadloop due to IRQ work")
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > Closes: https://lore.kernel.org/oe-lkp/202508071303.c1134cce-lkp@intel.com
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > ---
> > 
> > Can you please update testing results with the proposed fix?
> 
> now we finished the test with the proposed fix, it works. thanks!
> 
> Tested-by: kernel test robot <oliver.sang@intel.com>
>

Thanks for testing!


- Neeraj

> > 
> > 
> > - Neeraj
> > 
