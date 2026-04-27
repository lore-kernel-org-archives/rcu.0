Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7828F3BFE4C
	for <rcu@vger.kernel.org>; Mon, 27 Apr 2026 13:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777295313; cv=none; b=OCdNjx3l0UZT4zfevVqUbZJWew3uTNGMVbA55o/6204pWk6y7UcT4WLurSwwlu20XprzuvR3BgG/vz55vGyM3WJ4uxbstSP9t5MqmQ6paOzlFxdoslzVCNT4pFkCDRW1R4pYzLqQi5lHwx3ez31PMIY16hPIUy3mGIMNxBKa0cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777295313; c=relaxed/simple;
	bh=Zj8hZ7u33nqWt/MVqTENCSDelYZ/mQveeppH4hdN7H0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QLpQ+h5mqiWmpmaYc4UbEceG0CtZX3jJpkHbwquXfIHQl4ZelXSCSqK/FfA4Xpp3uXnlIxqfqgHRrpRell6jp0axDMChKvNh1TOp2997uBIIts4Y6KKeuSSQ1306v8Fh89CRAkFx0k2ga8GNVhEWDNi8yY19x9grQFN23gr4HvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XrvWPqMC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XrvWPqMC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0FFC19425;
	Mon, 27 Apr 2026 13:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777295313;
	bh=Zj8hZ7u33nqWt/MVqTENCSDelYZ/mQveeppH4hdN7H0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XrvWPqMCqxm5VmQ/G7JvRjOZ0pTxS0B2T7cuhva6/kiM6eo2MlZG1OXWA2SwBjxHI
	 AP9fIs17Emyal1DHLrPugMLT4XwLsfw8VNs1awLkhR9i8rTGzbaKuOExBVeXZt0DHj
	 e88hH2zU0DQvICu6o3hSnISwB52h7pJvdGCVHJ7i1C8BJdTN8uQx0Lac8OQ8YdneXq
	 WfdAj2/x4AN4PvcGovZmtl7iZQF0FNeg1SoKXbc7o3PmR7TV9peXCZIra40FXRKeea
	 cMp4oa1HT8mbOBL0GDP2v4d+P2hStoo5+4YuhsA3u8ZjrwXqAimSWj4TjILyTZ493W
	 w0tg+xesQM7Gw==
Message-ID: <9ee16679-969d-460b-af4a-9ad5a6a1ebcf@kernel.org>
Date: Mon, 27 Apr 2026 15:08:27 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] mm/slab: introduce kfree_rcu_nolock()
Content-Language: en-US
To: "Harry Yoo (Oracle)" <harry@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Zqiang <qiang.zhang@linux.dev>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
 linux-mm@kvack.org
References: <20260416091022.36823-1-harry@kernel.org>
 <20260416091022.36823-5-harry@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20260416091022.36823-5-harry@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/16/26 11:10, Harry Yoo (Oracle) wrote:
> +#ifndef CONFIG_KVFREE_RCU_BATCHED
> +void kvfree_call_rcu_head(struct rcu_head *head, void *ptr, bool allow_spin)
> +{
> +	if (!allow_spin) {
> +		struct kfree_rcu_cpu *krcp;
> +
> +		guard(preempt)();
> +
> +		krcp = this_cpu_ptr(&krc);
> +		if (llist_add((struct llist_node *)head, &krcp->defer_head))
> +			irq_work_queue(&krcp->defer_free);
> +		return;
> +	}
> +

Given "allow_spin" is compile-time constant, it would make more sense to
have different functions for each variant rather than calling a common one
with the extra param?

>  	if (head) {
>  		kasan_record_aux_stack(ptr);
>  		call_rcu(head, kvfree_rcu_cb);
