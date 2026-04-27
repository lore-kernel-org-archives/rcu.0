Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D64319539F
	for <rcu@vger.kernel.org>; Mon, 27 Apr 2026 18:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777313329; cv=none; b=LbvLCYJJrVsfzuA3xCzIVpnJfSQLmI84sEQB9vgu7Us/EJgFu8n56TqHnm17k79eYZiSkrawa8VD1hLU0rrOxaH2P3WvHccwrPmwj+hip79QDLqdGUbTUFng1YI9ROxKIo1Zs4UYaDwpDTs2xZYfUtV6p0W/8XD98qi6dmmeUYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777313329; c=relaxed/simple;
	bh=kMOnCgiX7WpVxs78xhcWlnKUzjZBk7mOuOAbAYfMhT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d9hanBsAmkt/TSeuDM525csaGHOivO2D6GAuaX4UyATEGz58oKuB7D6K3e4DyjaxwgWdHD/Z7pqIKzq3mqoBaLw5q0p69KG9qjXxO2+J5RwQm1rv9y5wbn3/db65MPS6b1eOWhrw7+0L0cxb2RsRDk325Qd2UNNnxb04MTwRlqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8hM/Sjp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8hM/Sjp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCE1C2BCB5;
	Mon, 27 Apr 2026 18:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777313329;
	bh=kMOnCgiX7WpVxs78xhcWlnKUzjZBk7mOuOAbAYfMhT4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P8hM/SjpmKKZKJmglT7pAVfcHAU86kTR4se4kSUPHgn4/oZsyXSrw+osYDOr2t293
	 EIX1T9Zmwf8dZMAtX6WuHQgFG5aCkfIcJhY0NChlGYniVvZ0+cqEtVROdncgq5F2Cv
	 YhxOVohQ8Hysn9YyL5kbDU9Cwi6v5y2lKTlWwnH28nUMIP2HeFfUa5pcYHAiUCSqJ1
	 d3/MFY7RjFycpYB41K++kqc+aCsborMtRhb+Q6eo16w9IGyy5er+46OiuDDg7rXrfM
	 x+NsyF81dcltR1PleYs7YA+Hjw/qjvw/8ulDX+/09+j58tA9GPpKTXBJCXR+5lgQQX
	 03eTQsbitHNTw==
Message-ID: <7526f30a-a008-49bc-a064-07f4e4a7920b@kernel.org>
Date: Mon, 27 Apr 2026 20:08:43 +0200
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
 Uladzislau Rezki <urezki@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, "Paul E . McKenney"
 <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Zqiang <qiang.zhang@linux.dev>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
 linux-mm@kvack.org
References: <20260416091022.36823-1-harry@kernel.org>
 <20260416091022.36823-5-harry@kernel.org> <aejeVK0J_jHSfVhD@milan>
 <aelxH--hZkCahPv6@hyeyoo> <ael8R0vOeZ0Xbcoe@hyeyoo>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <ael8R0vOeZ0Xbcoe@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/23/26 03:56, Harry Yoo (Oracle) wrote:
> On Thu, Apr 23, 2026 at 10:08:49AM +0900, Harry Yoo (Oracle) wrote:
>> On Wed, Apr 22, 2026 at 04:42:28PM +0200, Uladzislau Rezki wrote:
>> > On Thu, Apr 16, 2026 at 06:10:18PM +0900, Harry Yoo (Oracle) wrote:
>> > As discussed or noted earlier, having third argument and check the
>> > entire path with "if (allow_spin)" is not optimal and is not good
>> > approach. I do not think it this would be a good fit for mainline.
>> 
>> I understand that this pattern is pretty uncommon and adds complexity.
>> But there is a reason why we're doing this. As Alexei pointed out
>> earlier, even rare spikes of irq_work hurt performance [1]; that can be
>> avoided in most cases where the lock is not in use. That's why buddy [2]
>> and slab [3] accepted this pattern despite the added complexity?
> 
> Perhaps we can avoid complicating existing kvfree_rcu batching
> (and still avoid hurting performance).
> 
> Given that kfree_rcu_nolock() (at least BPF) doesn't need to free
> vmalloc objects, we can make kfree_rcu_sheaf() handle most of frees
> (slab already knows how to handle allow_spin = false) and fall back to
> a simple irq_work as Ulad suggested.
> 
> But then we need to make kfree_rcu_sheaf() try harder (currently it
> gives up when it fails to get an empty sheaf from the barn).

Yeah, if there's a burst of kfree_rcu_nolock() calls, it might exhaust that.

> And I guess the tricky part is making kfree_rcu_sheaf() work on RT ;)

I hope we're close to that, as discussed on patch 5/8 :)

