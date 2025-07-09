Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C0629346B;
	Wed,  9 Jul 2025 11:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752061019; cv=none; b=JSRkZy3lAYreo85XcIsK6ZFcjWHQprX9FJBBqOAxJK6N3TzzS6jgKU1PPZNl0Q4qAGOS6MVSL4wUI2E3e6SZoyFSljnJZlEA5/I0Ahb0F0R+BQQ2ukFMRAcYRsn4GbwcgMAQK6TMlP8oFsErAEuN9Zw1d87HBBQH2rY1Hpz4uQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752061019; c=relaxed/simple;
	bh=IoPyQsMo0CBuHSM2wjigZc657/Kn1Fz4Cn0dRzHpySQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KT0cTDs9VQYqI80zUiOjPhoCrvmLrt+ByBSzH2aCrHT0OlFF7EJTvNUTAjThCX7gxCXr/82uEnGOGXJYJlzu81bnKVBujb7z8kgfFNvSjT6tl0ct1uDdy8+xk9eC+JzUnIs1oleVjIZoWqMv5BPeSNVONRXA85tiZZUcDGg9nsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQ59+//l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQ59+//l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3FFC4CEEF;
	Wed,  9 Jul 2025 11:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752061019;
	bh=IoPyQsMo0CBuHSM2wjigZc657/Kn1Fz4Cn0dRzHpySQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kQ59+//lk9y7bLmOt3bbemmvloK2T6R+NsmRNtccHDcA0NTNlULC/8NGDrEuzITsj
	 tUTrdSflhmddfxD3Xmvb74zgyH5d+YkYJoVMXOzxj1qfRVKnMVgbhoROoKBt5okR3i
	 VZonXW+ziubWjMRgivNsY7kwzgVJTZIIfsuspGT7PUfQOHESG945+u1WVDXzR6KuvZ
	 s8BEVuF34zsNDMjCgzmfhmvAFv1OEmz1onZ52D7oRx6loshp1w2Ug7t3o4E6xmHpEY
	 PtruC0SO0aExl86sgUBZ5NHwZ7hXrDyhognUugvjvhYT/PHA8oZ7cBKm3Qaqh8Vi+Y
	 wojGQ3ZRBLDWA==
Date: Wed, 9 Jul 2025 13:36:56 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: neeraj.upadhyay@kernel.org
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, paulmck@kernel.org,
	joelagnelf@nvidia.com, boqun.feng@gmail.com, urezki@gmail.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com, qiang.zhang1211@gmail.com,
	neeraj.iitr10@gmail.com, neeraj.upadhyay@amd.com
Subject: Re: [PATCH rcu 3/5] rcu: Enable rcu_normal_wake_from_gp on small
 systems
Message-ID: <aG5UWDQ0L3Utm8wT@localhost.localdomain>
References: <20250709104118.15532-1-neeraj.upadhyay@kernel.org>
 <20250709104118.15532-4-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250709104118.15532-4-neeraj.upadhyay@kernel.org>

Le Wed, Jul 09, 2025 at 04:11:16PM +0530, neeraj.upadhyay@kernel.org a écrit :
> From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> 
> Automatically enable the rcu_normal_wake_from_gp parameter on
> systems with a small number of CPUs. The activation threshold
> is set to 16 CPUs.
> 
> This helps to reduce a latency of normal synchronize_rcu() API
> by waking up GP-waiters earlier and decoupling synchronize_rcu()
> callers from regular callback handling.
> 
> A benchmark running 64 parallel jobs(system with 64 CPUs) invoking
> synchronize_rcu() demonstrates a notable latency reduction with the
> setting enabled.
> 
> Latency distribution (microseconds):
> 
> <default>
>  0      - 9999   : 1
>  10000  - 19999  : 4
>  20000  - 29999  : 399
>  30000  - 39999  : 3197
>  40000  - 49999  : 10428
>  50000  - 59999  : 17363
>  60000  - 69999  : 15529
>  70000  - 79999  : 9287
>  80000  - 89999  : 4249
>  90000  - 99999  : 1915
>  100000 - 109999 : 922
>  110000 - 119999 : 390
>  120000 - 129999 : 187
>  ...
> <default>
> 
> <rcu_normal_wake_from_gp>
>  0      - 9999  : 1
>  10000  - 19999 : 234
>  20000  - 29999 : 6678
>  30000  - 39999 : 33463
>  40000  - 49999 : 20669
>  50000  - 59999 : 2766
>  60000  - 69999 : 183
>  ...
> <rcu_normal_wake_from_gp>
> 
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs
