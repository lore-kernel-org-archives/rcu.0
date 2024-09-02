Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B4B19E96D
	for <rcu@vger.kernel.org>; Mon,  2 Sep 2024 12:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725279439; cv=none; b=ZHeyz5Z4UdG8sJprnfUhHtjLHqrYwzmDmX8l7kymsNQeJoqpp3+RdRsB5XKRqb5AYQkyFWT3ja18D9JkcsGf0sKxenpQCuQQySfHmvErVi33ChzejTnujyAE7oX/ygAItDubZqFwAJEMYa7DyvTczS4/ZPWWSmCpqTB13QjbX9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725279439; c=relaxed/simple;
	bh=N+2vNMITDQcU8VD3fB8pzfJ3amsb2MwR3lK5OrpWSlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CjT6D7z2AEod4X17F656YQDcFewKTNPpwYt0ehmDZl0/PbJh21/E6zSgn2JhfltuH3ysgiHzGrwbRhj85+YaV3vSPA9WRTep/9eVfbilGPEWo9mdQF2gu4oNNjfBQ97GIehWjH8CfFUJljOLnSEgf23056IfWWZ8UrZN+fSPmT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=B2Kx6WpX; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="B2Kx6WpX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1725279427;
	bh=N+2vNMITDQcU8VD3fB8pzfJ3amsb2MwR3lK5OrpWSlc=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=B2Kx6WpXYoF99wBka2UZWbuvcPPgY5igkha7fUJDLUEmXST0GBjJcOjfXFKP+Ub7M
	 T9uDfWkmi9suHoRH9kALzC5VLCjfGFF74cTISlStY3nbbrEXmJDai5qbVLFIrNcXqK
	 7/dpaTyxCWE4OFLnX2aTfLoTbGonxXauapgZjhsLXHuJOWS1RWDEtmlAHEeBlIwUM/
	 SWlxgNp7ACO+TDxsQ9/9pZT0E4gyGuqxyvc3jmVRfuEyOV7KjOQq+qjd08FmT5YDwV
	 yumsU+OhyC1ITGhFqXUu9VKcQTHtQ1xK/1ZvvHQGyRPeQBBOoBdT5VGjDPBwQCgGrn
	 tfaa050pVOGww==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Wy76W2HZXz1Jrx;
	Mon,  2 Sep 2024 08:17:07 -0400 (EDT)
Message-ID: <5ff34e5e-dbeb-4ea3-820c-8def6a723133@efficios.com>
Date: Mon, 2 Sep 2024 08:16:46 -0400
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] rcu: Use the BITS_PER_LONG macro
To: Jinjie Ruan <ruanjinjie@huawei.com>, paulmck@kernel.org,
 frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
 josh@joshtriplett.org, boqun.feng@gmail.com, urezki@gmail.com,
 rostedt@goodmis.org, jiangshanlai@gmail.com, qiang.zhang1211@gmail.com,
 rcu@vger.kernel.org
References: <20240902110654.2685917-1-ruanjinjie@huawei.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20240902110654.2685917-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-09-02 07:06, Jinjie Ruan wrote:
> sizeof(unsigned long) * 8 is the number of bits in an unsigned long
> variable, replace it with BITS_PER_LONG macro to make it simpler.

An alternative would be:

if (rcu_fanout_leaf < 2 || sizeof_field(struct rcu_node, qsmask) * CHAR_BIT) {

which would then tie the check to validated member type. But it's
slightly more verbose, so it's up to the maintainer really.

Thanks,

Mathieu

> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>   kernel/rcu/tree.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index a60616e69b66..b48864df415c 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -5579,8 +5579,7 @@ void rcu_init_geometry(void)
>   	 * Complain and fall back to the compile-time values if this
>   	 * limit is exceeded.
>   	 */
> -	if (rcu_fanout_leaf < 2 ||
> -	    rcu_fanout_leaf > sizeof(unsigned long) * 8) {
> +	if (rcu_fanout_leaf < 2 || rcu_fanout_leaf > BITS_PER_LONG) {
>   		rcu_fanout_leaf = RCU_FANOUT_LEAF;
>   		WARN_ON(1);
>   		return;

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

