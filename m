Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8253B3ED5CA
	for <rcu@vger.kernel.org>; Wed, 22 Apr 2026 14:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776868885; cv=none; b=OcFU5fvxVCkSZxmW+N5yxHK7u4mJ7erocvug/SkFNUk1m94z9P0A85dWEfSpK+15xTAQ55o4sjM8XF5hl5gq3oleRIHgrmrdI5OH03k0JjlIRcTBcDmQBcXQ+pwCXBE1tY8dPzq5jl5SSLKvx+6q4EV38tPZW/SjczsFCA6777o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776868885; c=relaxed/simple;
	bh=sBZkncgimPUsAy5Xxrwc3HtnSUuzhD/pRnZRRpvSt1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OzLRbLLRlgkW/QzEaP2+O7OSrsS4t2E0Jznko6QRJuH1cregvi7GLPsOEUghLQAU2w6sDivQGt4E0Q+80QhW/7TpyHaXv3JEH6kVWEVu4tl0kQW7gb4Av3Ja/lEiOnW5DME5ZSUzWxXMwEaH7b/7BVVGAOYej5ptYHM9jV27PBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQgta47K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQgta47K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8DA1C2BCB7;
	Wed, 22 Apr 2026 14:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776868885;
	bh=sBZkncgimPUsAy5Xxrwc3HtnSUuzhD/pRnZRRpvSt1s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CQgta47KOpcVfZ8dy283/Lp6ixHiNUQH+BmGB4A+Atnyn81bVCZ7G5i2ronKUv9k1
	 gruA+0U3wVxM4Qfs54lJMo1c+joC70nhY1n4RdejDFbnaXiUisQ5aYW2HhrGQsKP9D
	 Jv9OjP9Ugr6xZ6swXPalrB4qAGA6S1ZbEMSVjQjwjLacIvaEzNyB6WWdXsou9weC/s
	 BRlXxFHZWrxIul2fIbS7a091ttgsiV9zSIHlGAttVwIw+2sLK8GcGvmdmKpnBMgpWc
	 mlOoiOF3a0myqj8JlcDPCtxwIYXUjhqEBPimuhGhRAjjE9Rq241mfv05QI/vM16A86
	 jNrwMEppT+/Mg==
Message-ID: <baa235a3-59c4-420e-8f1e-40c8526f3bf2@kernel.org>
Date: Wed, 22 Apr 2026 16:41:19 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] mm/slab: introduce k[v]free_rcu() with struct rcu_ptr
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
 <20260416091022.36823-2-harry@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20260416091022.36823-2-harry@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/16/26 11:10, Harry Yoo (Oracle) wrote:
> @@ -1523,18 +1522,34 @@ kvfree_rcu_bulk(struct kfree_rcu_cpu *krcp,
>  }
>  
>  static void
> -kvfree_rcu_list(struct rcu_head *head)
> +kvfree_rcu_list(struct rcu_ptr *head)
>  {
> -	struct rcu_head *next;
> +	struct rcu_ptr *next;
>  
>  	for (; head; head = next) {
> -		void *ptr = (void *) head->func;
> -		unsigned long offset = (void *) head - ptr;
> +		void *ptr;
> +		unsigned long offset;
> +		struct slab *slab;
>  
> +		if (is_vmalloc_addr(head)) {
> +			ptr = (void *)PAGE_ALIGN_DOWN((unsigned long)head);
> +		} else {
> +			slab = virt_to_slab(head);
> +			if (!slab)
> +				ptr = (void *)PAGE_ALIGN_DOWN((unsigned long)head);
> +			else if (is_kfence_address(head))
> +				ptr = kfence_object_start(head);
> +			else
> +				ptr = nearest_obj(slab->slab_cache, slab, head);
> +		}

It seems a bit wasteful to do this... (especially the virt_to_slab()) part.

> +
> +		offset = (void *)head - ptr;
>  		next = head->next;
>  		debug_rcu_head_unqueue((struct rcu_head *)ptr);
>  		rcu_lock_acquire(&rcu_callback_map);
> -		trace_rcu_invoke_kvfree_callback("slab", head, offset);
> +		trace_rcu_invoke_kvfree_callback("slab",
> +						(struct rcu_head *)head,
> +						offset);
>  
>  		kvfree(ptr);

... and then throw it all away and let kvfree(ptr) do it again. So maybe we
could then call something more internal and specific based on the result of
the above.


