Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470012459CF;
	Tue,  5 May 2026 00:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777942755; cv=none; b=fz565PLcKDmmowoJBb4M2+/DuOOtMEDfMfCW0wVPBGRBGAK3BNzfrU8cii0RpJs5yH3c2daqYjH9tQ3TBhAN+AXOWECnQwhqtoHbXbMt/YbZSQiqtP+SnC0TGiDa/craI+d4Om9TqixtRvJJP4jzaZo7Tk4ds5ZIcinVJ1qm9mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777942755; c=relaxed/simple;
	bh=Ss8RvpRPBoQ6JWpf/aYEWCNFdn6pygCcs9D+eE2u5GY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=q+qCu5KQPQab7wwXzvq/PAi6Zw6njhC5CQ3T9NligZq0WkXh6nLGZBlAaJYianH1ikf0+93lbw7Uz7BdS+75Thhq/yH9/TjF7UvrOxddvVr7+taHGgNW7G67p6oXsVzedOG5N8l5AEfDPHP3RC77LYi3ZS439coDq/d5XFA4HWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRCEMUJM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRCEMUJM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE293C2BCB8;
	Tue,  5 May 2026 00:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777942754;
	bh=Ss8RvpRPBoQ6JWpf/aYEWCNFdn6pygCcs9D+eE2u5GY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KRCEMUJMGePst7lUCnhEuGBAWy6k5HRrqmQzJCx3wbRFdUV9+lU25LVGzPWv4h4bq
	 yhPW2/InYbVDNzbZiLZsRcCZaS8RUsCkOzZqlj8dQmulMA7LOUhbByprLTJOUJMDFR
	 CJiMgpsvfrFy10IRbIw9dvz8/kwm3Avca4HQt99idMQVH+tHzEenTW1vimEt359sQ2
	 RHvDl4TxUA3t8nf7/+gxL+y6arqIQr+yqnYPcEfbzXkIYhjo/eA1Q8wNJ4kBRXe8Cz
	 n7f+u4uihJX83bjBy5YNO7jqLSY4YTdO1niG2LSFxFl6M8NAU63oD+xlJIKUYG878+
	 OlEvFmE1jG+4Q==
Date: Mon, 04 May 2026 14:59:13 -1000
Message-ID: <8f3d856b5b2a9dc6c84b480d934007ac@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev,
 David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 rcu@vger.kernel.org,
 Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v2 2/2] sched_ext: Fix exit_cpu accuracy for lockup paths
In-Reply-To: <20260504161543.674488-3-yphbchou0911@gmail.com>
References: <20260504161543.674488-1-yphbchou0911@gmail.com>
 <20260504161543.674488-3-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

Hello,

> -		panic_on_rcu_stall();
> +		panic_on_rcu_stall(raw_smp_processor_id());

This one in synchronize_rcu_expedited_wait() - is raw_smp_processor_id()
the right CPU here? The wait runs in the grace-period worker context,
so the current CPU is the waiter, not a stuck one. The stuck CPUs are
the ones in rnp->expmask that synchronize_rcu_expedited_stall() just
iterated over.

Thanks.

--
tejun
