Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA38306B3D;
	Fri, 31 Oct 2025 21:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761946380; cv=none; b=J5zwGNPmXncFGF/pRdDi7jF86w+hi8eNkR2fUpOT60oUVGnP8ncHDmpDRf0vbZig8EdflUBGXl1+rHZN1c1efBcCoWKWWaohSjjSlIdL0d1TAde/irBefNDvPCdUa7v18omwllNO/XZd3kDwZB4eaAvf4SOR0KIf/+CNJIvIOGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761946380; c=relaxed/simple;
	bh=Q4jsAPOYgiCp2KBXrG94dO+Z5cGNiyamdcVsqHPG6eM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gfmp+KxaAE6u9vCd8fyS2VyIvvXWjkgxfZCgVCD1T+IqnJk8JiEiV6pNN2pFGuTVhP38a/SBVAJS47EwO6iGr1rm5NVtytTEPaxVLPL81FOQawyr5yo9ijTkcjGuYaY0odz7Fye5ZQ7SFE7+z2hB6o8A6MOP5kU9tY3w3XToros=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=scPetG/8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="scPetG/8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE0BC4CEE7;
	Fri, 31 Oct 2025 21:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761946379;
	bh=Q4jsAPOYgiCp2KBXrG94dO+Z5cGNiyamdcVsqHPG6eM=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=scPetG/8GyxPOp5NeOGZMQrNgPWI6rBtLqVJwmQQNXxtmixSR3lctbzXBP3bSETJ8
	 OnAwpatmqDVSwsZHVga36biummiWSTCJxbHFjyYwYG7pAY5n56+e3Pjn/pN3h8yYtI
	 WvetyPgBQY5r4jDatzGOP2vVqyLwBDghoLO6HkUcEcyxL7LcVQppeGf/rRaghjt9h3
	 yMqziMyZ+vWh+J4B5F7NaP/Qk1AOWN8nmdvBs7UqjgOusnmkNkziqzA0jsSudpR15p
	 rSvl24o0f6k6NRcC5UexL876spmEuDWkRhQFNLqd1RKl3xWRhtTlnjCtuKNbx92PNH
	 wjOO4lNYT4ufg==
Message-ID: <0406562e-2066-4cf8-9902-b2b0616dd742@kernel.org>
Date: Fri, 31 Oct 2025 22:32:54 +0100
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH v8 04/23] slab: add sheaf support for batching kfree_rcu()
 operations
To: Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
 Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>,
 Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 maple-tree@lists.infradead.org, linux-modules@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <20250910-slub-percpu-caches-v8-4-ca3099d8352c@suse.cz>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250910-slub-percpu-caches-v8-4-ca3099d8352c@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/09/2025 10.01, Vlastimil Babka wrote:
> Extend the sheaf infrastructure for more efficient kfree_rcu() handling.
> For caches with sheaves, on each cpu maintain a rcu_free sheaf in
> addition to main and spare sheaves.
> 
> kfree_rcu() operations will try to put objects on this sheaf. Once full,
> the sheaf is detached and submitted to call_rcu() with a handler that
> will try to put it in the barn, or flush to slab pages using bulk free,
> when the barn is full. Then a new empty sheaf must be obtained to put
> more objects there.
> 
> It's possible that no free sheaves are available to use for a new
> rcu_free sheaf, and the allocation in kfree_rcu() context can only use
> GFP_NOWAIT and thus may fail. In that case, fall back to the existing
> kfree_rcu() implementation.
> 
> Expected advantages:
> - batching the kfree_rcu() operations, that could eventually replace the
>   existing batching
> - sheaves can be reused for allocations via barn instead of being
>   flushed to slabs, which is more efficient
>   - this includes cases where only some cpus are allowed to process rcu
>     callbacks (Android)
> 
> Possible disadvantage:
> - objects might be waiting for more than their grace period (it is
>   determined by the last object freed into the sheaf), increasing memory
>   usage - but the existing batching does that too.
> 
> Only implement this for CONFIG_KVFREE_RCU_BATCHED as the tiny
> implementation favors smaller memory footprint over performance.
> 
> Also for now skip the usage of rcu sheaf for CONFIG_PREEMPT_RT as the
> contexts where kfree_rcu() is called might not be compatible with taking
> a barn spinlock or a GFP_NOWAIT allocation of a new sheaf taking a
> spinlock - the current kfree_rcu() implementation avoids doing that.
> 
> Teach kvfree_rcu_barrier() to flush all rcu_free sheaves from all caches
> that have them. This is not a cheap operation, but the barrier usage is
> rare - currently kmem_cache_destroy() or on module unload.
> 
> Add CONFIG_SLUB_STATS counters free_rcu_sheaf and free_rcu_sheaf_fail to
> count how many kfree_rcu() used the rcu_free sheaf successfully and how
> many had to fall back to the existing implementation.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Hi Vlastimil,

This patch increases kmod selftest (stress module loader) runtime by about
~50-60%, from ~200s to ~300s total execution time. My tested kernel has
CONFIG_KVFREE_RCU_BATCHED enabled. Any idea or suggestions on what might be
causing this, or how to address it?
