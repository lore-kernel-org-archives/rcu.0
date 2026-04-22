Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A533F3ED5C8
	for <rcu@vger.kernel.org>; Wed, 22 Apr 2026 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776868214; cv=none; b=el8KbRpMPRcE4Lji3CboSaoj6kW0d2k+i2fOXH7s3MR9U5XYOdTki/rX2rqZfjdIit6aDa+GcV40qNAWDxr7Be2qg0roSb3rptS6PRePvqX87hP1YeebI2WqzxCbKgUhkFbtwpeOghWolvQ57EeUBeU2fyy1fzTn2wipzxiQBZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776868214; c=relaxed/simple;
	bh=+AApuSx3VUN8zmQL3aTVwqVWL1Kh6nlC5CEFRlMZEpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VpQq5UJV4EE2t4EyfnraZIMCGe9Q5mhyf89Hd4qJ/zvRu+NgpRxqsnkWVQ6hR/pQ19ENVJ4/AE3XlvOfqgZgUv0/WT96ta6hOHlXEfdcJtZ0W5Cpyq2LKqZrPSF4iSe1dwu+HvJq3vn6skr3WdozTITmmTJP73lKIzP1MvHmFog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsS4Z1Mk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsS4Z1Mk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91268C19425;
	Wed, 22 Apr 2026 14:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776868213;
	bh=+AApuSx3VUN8zmQL3aTVwqVWL1Kh6nlC5CEFRlMZEpE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XsS4Z1MkUUltQ9hnKB98bBEiDYfF1hFZ1JtMBSsNSRkS0ws1n3u+JLIYk+aKCoxrw
	 tMTbC/XcvqfEs8c5MLPIqgTD1uQnP90JwuT/Ys3zJd/lRDS+aj6qMZQHlynSYdD7Qj
	 hO2IDF8sG1Pz2bjCly+NVZn0qHGTVHishJIzjEwdpsx+e/PdmO8I+k/TF7lJtbhBpy
	 WppBjFM7VWAY8p2BReqnSNdMqu8t41/+iVe0IexXJpNMYI8fGHAOe1E7RSL59Dl+sl
	 zq3Fs+rLGdE6pylbwsxdjOaBPRzSBu0ch7KaS2ZacFkLJ8UVZ3HftBh38fMtWIrNE7
	 eNIBhZfBQ7UUg==
Message-ID: <214ca3ac-45b7-4131-86e5-ac134ab0bcbd@kernel.org>
Date: Wed, 22 Apr 2026 16:30:07 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/8] kvfree_rcu() improvements
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
 linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
References: <20260416091022.36823-1-harry@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20260416091022.36823-1-harry@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/16/26 11:10, Harry Yoo (Oracle) wrote:
> # Part 1. Allow an 8-byte field to be used as an alternative to
>   struct rcu_head for 2-argument kvfree_rcu()
>   (patches 1-2)
> 
> Technically, objects that are freed with k[v]free_rcu() need
> only one pointer to link objects, because we already know that
> the callback function is always kvfree(). For this purpose,
> struct rcu_head is unnecessarily large (16 bytes on 64-bit).
> 
> Allow a smaller, 8-byte field (of struct rcu_ptr type) to be used
> with k[v]free_rcu(). Let's save one pointer per slab object.
> 
> I have to admit that my naming skill isn't great; hopefully
> we'll come up with a better name than `struct rcu_ptr`.

"rcu_ptr" sounds too generic to me. Things like rcu_dereference() talk about
"RCU-protected pointer" and it could be misleading that "rcu_ptr" has
something to do with this. Only if Paul think it's ok :)
But maybe just "kvfree_rcu_head"? As IMHO It's an rcu_head specialized for
kvfree.
