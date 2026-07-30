Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87E3367F2F;
	Thu, 30 Jul 2026 03:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785380933; cv=none; b=Z6qiImiM3/IxMNlA5FDoWcndwN0G8v27joahHyIwa3YTlSaED2ZkQchi7QTiE+zOG2eB3VvdS+6dZKLeTpx9aPQ4D2mD1S+sWG5/wzHYPjnkTQe1tZXKXqdSv2pAYMOTdnYSR9CX1GPU0tYhTM0BySKvuNrzU+XqpqNeE0SLbhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785380933; c=relaxed/simple;
	bh=RXUJcPQ0nd7RDchKXPgt+jkCnXJ1MtGPAWTqSFTEyXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BdV2d1aXzewQ2hiiaO7JvVIK9y0WFx0UwzZ7tcMVMuHuacUKMojpw2+Z1HEww1vpf3+F886C7Lh5ubx0i5NweAcfpRXkyB9cbWb0gd8vR7pMwCQcMAkoN6SqUIL9x2vCjUVY4sXPsFFKCdLBYTrGdZl8m4IDnoaimzRKAjHlV3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fkb51iDq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fkb51iDq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B9F1F000E9;
	Thu, 30 Jul 2026 03:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785380931;
	bh=JFYplbxEhQ00hEvZ5hng6YDKKuCP2Lh5XB9nlXgKZ7o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Fkb51iDqkqLHhVoJ5kwF3219gubEw0+gbN9PTrmEy6rMkapWH7oDh37pFO+af77/p
	 kahJV9sx2eIC5HeZEEK5a4hik06jV5Zj94qDu1RFbxTuppTEsUCTMQco42MDHgMdnn
	 4B5D1ck16rJRGRY8IfDwuJwucgu6QHd0hpvL1J3gEXQ1MmVC7ufOXWqkqyu1ph7nZ8
	 tjhCBvGb8Ow0Zy8k5pqlD5tmdBpqIjJZX4uOT8jHL61KSaS3rYAcz1sDDv1N14ff0T
	 85D3zm7H5b/fEVJBzh3I8jE7+3KKEuFiUGgOScu24FS2KR4fTV0BwKMeqOlHT0qAM7
	 tD7nZxZ/SveFA==
Message-ID: <f97853e9-3021-4f20-81d3-4bb710ca444a@kernel.org>
Date: Thu, 30 Jul 2026 12:08:44 +0900
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] mm/slab: introduce kfree_rcu_nolock() and improve
 slub_kunit coverage
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>, Amery Hung <ameryhung@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Pedro Falcato <pfalcato@suse.de>, Suren Baghdasaryan <surenb@google.com>,
 Shengming Hu <hu.shengming@zte.com.cn>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, rcu@vger.kernel.org, bpf@vger.kernel.org
References: <20260729-kfree_rcu_nolock-v5-0-a28cdcda9673@kernel.org>
 <5342124c-4847-4e93-92a4-f3512928c4d1@kernel.org>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <5342124c-4847-4e93-92a4-f3512928c4d1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/29/26 11:14 PM, Vlastimil Babka (SUSE) wrote:
> On 7/29/26 10:20, Harry Yoo (Oracle) wrote:
> 
> ...
> 
>> 8:  8e69c83a1e52 ! 8:  aeaf2ab60046 slub_kunit: extend the test for kfree_rcu_nolock()
>>     @@ lib/tests/slub_kunit.c: struct test_nolock_context {
>>      -			gfp_t gfp = (i % 2) ? GFP_KERNEL : GFP_KERNEL_ACCOUNT;
>>      +			gfp_t gfp = (i & 1) ? GFP_KERNEL : GFP_KERNEL_ACCOUNT;
>>       
>>     - 			objects[j] = kmalloc_obj(*objects[j], gfp);
>>     +-			objects[j] = kmalloc(64, gfp);
>>     ++			objects[j] = kmalloc_obj(*objects[j], gfp);
>>       			if (!objects[j]) {
>>     + 				j--;
>>     + 				while (j >= 0)
>>      @@ lib/tests/slub_kunit.c: static void test_kmalloc_kfree(void)
>>       			}
>>       		}
>>
>> Link: https://lore.kernel.org/linux-mm/20260427-nolock-api-fix-v2-0-a6b83a92d9a4@kernel.org [1]
>> Link: https://lore.kernel.org/linux-mm/6edebc2b-5f5a-4b9c-9a4c-564310acee1b@kernel.org  [2]
>> Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
>> Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
>> Link: https://lore.kernel.org/linux-mm/872bd673-3d45-4111-8a41-31185db3ece5@kernel.org
>> Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
>> Link: https://lore.kernel.org/linux-mm/6811cc17-8ee4-48c8-8cbf-6bf4d9f98162@kernel.org [1]
>> Link: https://lore.kernel.org/linux-mm/40591888-3a87-433e-b3d2-cda1cab543be@kernel.org [2]
>> Suggested-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
>> Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
>> Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
>> Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
> 
> Wonder what produced this weird block of assorted trailers? "b4 prep
> --compare-to vX" never did that for me?

Interesting. I checked it again with `b4 prep --compare-to v4`, but the
command didn't produce this. Looking at the cover letter
`b4 prep --edit-cover` It's not even there.

Probably it was produced during b4 send --no-sign? hmm...

>> ---
>> Harry Yoo (Oracle) (8):
>>       mm/slab, slub_kunit: register kprobe to trigger _nolock APIs
>>       mm/slab: handle the !allow_spin case in kfree_rcu_sheaf()
>>       mm/slab: use call_rcu() in unknown context if irqs are enabled
>>       mm/slab: extend deferred free mechanism to handle rcu sheaves
>>       mm/slab: allow kfree_rcu_sheaf() on PREEMPT_RT
>>       mm/slab: introduce struct kvfree_rcu_head for kvfree_rcu batching
>>       mm/slab: introduce kfree_rcu_nolock()
>>       slub_kunit: extend the test for kfree_rcu_nolock()
>>
>>  include/linux/rcupdate.h   |  32 ++++++-
>>  include/linux/slab.h       |  16 +---
>>  include/linux/types.h      |   8 ++
>>  include/trace/events/rcu.h |   2 +-
>>  lib/tests/slub_kunit.c     | 190 ++++++++++++++++++++++++++++-----------
>>  mm/slab.h                  |  52 ++++++++++-
>>  mm/slab_common.c           |  81 +++++++++++++----
>>  mm/slub.c                  | 220 ++++++++++++++++++++++++++++-----------------
>>  8 files changed, 433 insertions(+), 168 deletions(-)
> 
> Applied to slab/for-7.3/kfree_rcu_nolock and merged go slab/for-next, thanks!

Thanks a lot!

> Used slab/for-next-fixes as a base for a better topic branch indepdencence.

Ah, I see. thanks.

So slab/for-next is not a good base unless it depends too much on
existing commits on the branch?

And usually it's better to use the base (slab/for-next-fixes,
in this case) of slab/for-next as a base?

>> ---
>> base-commit: ffc64805cebac330b2a60b2f1f144fcc35b8ab46
>> change-id: 20260615-kfree_rcu_nolock-e5502555992f
>>
>> Best regards,

-- 
Cheers,
Harry / Hyeonggon
