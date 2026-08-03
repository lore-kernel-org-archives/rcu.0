Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A678837F33B;
	Mon,  3 Aug 2026 07:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785743989; cv=none; b=h1IqQY9/SPH4XfSv6KcvONkCOzBqk7jo9TsY2RNaWPmdc/o3yZvkNrSdBT60ixKFn5ZlS6Ef+oyGNDCb+7ba0QgYaZ239t5K+3ZpbAMZHCNf+I+vPH1PU5pKv2BycZOty1b0hmiAQA5io7J3frV5y0prNl//UwGdqDvdeFEcZGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785743989; c=relaxed/simple;
	bh=/LN3SgVRVJHTNjBwPNrHLS9cRncZ/9/lzOonVVQ6wvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vDSG0tk71rbBapVaFxkZoO6IPA6JGyCVcLQoWS0HLACyXJe37PljTsE9aKfxi9rx0jfP1cB6FjrqUU/gML9X0pvK8YgBbkEpn+68BHuaRo9lXcHVeWUge46Y6QkICc1QldfxuGPZHtxZ7Lysd9+Pa8JR0PZLp9Zt7U1OqVmcj18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6x89Ii5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6x89Ii5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302A71F000E9;
	Mon,  3 Aug 2026 07:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785743988;
	bh=hsn1KsK/5eC7jnlXNMG0EcugFZK3YL3Y70CXScw+FU4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=l6x89Ii55cOr7kXhH1CEmN2arHvrvbHSmgwQiU7piZMOxpHd/Rx7qORHW1zMZfGfo
	 NWkUjQ6e7z1fEWkg39ucRETA5UNetU1PRoMiDaQeiVNIwVsbKcTiH2f5CD1ShbYKWO
	 FnP/ViZw92rYOX4LyrSwHo9AzfppQLkmPOJBfVuz76xn3zhqbZ/ClSUR3upCT74n9c
	 L8wX+mdcqB6FAq359hULhW25YH0xjkPEbtIqk0CEDiakc+U2ZmpoI67AIvOP9fVPu7
	 RtxPsarKoxsIJOuiVT6hscNjpNFqkGsE/dclzlwoI8R9FJJ9/Q0G2KRiHCfcmLOuLD
	 021lURTb0sZug==
Message-ID: <c4057657-7246-48ce-80d0-123e351a921b@kernel.org>
Date: Mon, 3 Aug 2026 09:59:44 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/slab: stop exporting kvfree_rcu_barrier[_on_cache]()
To: paulmck@kernel.org
Cc: Harry Yoo <harry@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Hao Li <hao.li@linux.dev>, Uladzislau Rezki <urezki@gmail.com>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
 rcu@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260730-unexport-barriers-v1-1-852f6641abe9@kernel.org>
 <d2cd0e92-930f-44e4-96e5-67b751419a1c@paulmck-laptop>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Content-Language: en-US
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <d2cd0e92-930f-44e4-96e5-67b751419a1c@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/30/26 22:59, Paul E. McKenney wrote:
> On Thu, Jul 30, 2026 at 04:32:46PM +0200, Vlastimil Babka (SUSE) wrote:
>> No module code calls these functions directly. Seems it was always the
>> case. Remove the exports.
>> 
>> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> 
> Acked-by: Paul E. McKenney <paulmck@kernel.org>

Thanks!

> Which reminds me...  Are you guys interested in taking the kfree_rcu()
> test code from kernel/rcu/rcuscale.c?  See for example the kfree_rcu_test
> module parameter.

Hmm, we have a slub kunit test, but I think no such torture/scaling test
infra. Maybe once we have that? What do you think, Harry?



> 							Thanx, Paul
> 
>> ---
>> Based on slab/for-7.3/kfree_rcu_nolock
>> ---
>>  mm/slab_common.c | 4 ----
>>  1 file changed, 4 deletions(-)
>> 
>> diff --git a/mm/slab_common.c b/mm/slab_common.c
>> index 6750dfa27367..cd155ffc2762 100644
>> --- a/mm/slab_common.c
>> +++ b/mm/slab_common.c
>> @@ -1329,14 +1329,12 @@ void kvfree_rcu_barrier(void)
>>  	deferred_work_barrier();
>>  	rcu_barrier();
>>  }
>> -EXPORT_SYMBOL_GPL(kvfree_rcu_barrier);
>>  
>>  void kvfree_rcu_barrier_on_cache(struct kmem_cache *s)
>>  {
>>  	deferred_work_barrier();
>>  	rcu_barrier();
>>  }
>> -EXPORT_SYMBOL_GPL(kvfree_rcu_barrier_on_cache);
>>  
>>  void __init kvfree_rcu_init(void)
>>  {
>> @@ -2163,7 +2161,6 @@ void kvfree_rcu_barrier(void)
>>  	flush_all_rcu_sheaves();
>>  	__kvfree_rcu_barrier();
>>  }
>> -EXPORT_SYMBOL_GPL(kvfree_rcu_barrier);
>>  
>>  /**
>>   * kvfree_rcu_barrier_on_cache - Wait for in-flight kvfree_rcu() calls on a
>> @@ -2186,7 +2183,6 @@ void kvfree_rcu_barrier_on_cache(struct kmem_cache *s)
>>  	rcu_barrier();
>>  	__kvfree_rcu_barrier();
>>  }
>> -EXPORT_SYMBOL_GPL(kvfree_rcu_barrier_on_cache);
>>  
>>  static unsigned long
>>  kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
>> 
>> ---
>> base-commit: b01f6ed9ff0c4581fc669044fa5b82a93b4ef144
>> change-id: 20260730-unexport-barriers-439b3f69f791
>> 
>> 

