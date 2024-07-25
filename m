Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD9719DF97
	for <rcu@vger.kernel.org>; Thu, 25 Jul 2024 17:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721926939; cv=none; b=Uq0swuMafnpZOxgCxdzvf9sBoKLGItF2g0o9s5wliXL/gRJUPRQhZti+yGo7XPp6CaLEKxIsu1LbvqsaIyeVQ+TYJYQXmEEyZjTGms0DWxp36n1iPx00zpGFZddoZ7RXY4l4ddEMk5AgJQx8vwF4juP6BWwgtvSSgnX4LTY41LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721926939; c=relaxed/simple;
	bh=kTokRip6+zG139kcI4R3CFeRyk8ffJ8yT6wEqIiNPgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AOulG8Pp0ZvVV6rGEyh9E4nCZM85Q5VS7gHkhZtoy0PTKL5iqvC5LKkjrBEy+M0uM49AbqcE0ehnkPwJg6s/T0tosib1xa1GJ6lOHS5F7nrlcqgRjHiqPwGuYZZf/F4iRZ5iMKrSGUdbmI/hGlD5yh8MycDXE1q6qhh1HGHAGT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dzhQejrL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dzhQejrL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721926937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WBSxPgh64JOs+4ms35CG8zRXGEwO0ju9A2tPRKm0s4E=;
	b=dzhQejrLs6vPEzMRRUK3QpbKwwHrETxudHos6xURy+tgjr3feV1oJVEBq/NCisR+mbKQ9e
	RxN7aHd4XmG2z/E2acDX0SEWjw2C19gglfMXnOne29CSdjR4/P3lJxRqu9CUITpeBiwqD5
	ltm2rA+h3RrQl+WDd7v7nP5+XU6d9l0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-27ytda8vNNiDWsx6fWT4XQ-1; Thu,
 25 Jul 2024 13:02:10 -0400
X-MC-Unique: 27ytda8vNNiDWsx6fWT4XQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7FE7F1955BF2;
	Thu, 25 Jul 2024 17:02:08 +0000 (UTC)
Received: from [10.2.16.78] (unknown [10.2.16.78])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8335D1955D42;
	Thu, 25 Jul 2024 17:02:03 +0000 (UTC)
Message-ID: <96aec91c-aa5c-4352-b93c-323b22011370@redhat.com>
Date: Thu, 25 Jul 2024 13:02:01 -0400
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Use system_unbound_wq to avoid disturbing isolated
 CPUs
To: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
 Vratislav Bendel <vbendel@redhat.com>
References: <20240723181025.187413-1-longman@redhat.com>
 <20240725153552.GA927762@neeraj.linux>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240725153552.GA927762@neeraj.linux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 7/25/24 11:35, Neeraj Upadhyay wrote:
> On Tue, Jul 23, 2024 at 02:10:25PM -0400, Waiman Long wrote:
>> It was discovered that isolated CPUs could sometimes be disturbed by
>> kworkers processing kfree_rcu() works causing higher than expected
>> latency. It is because the RCU core uses "system_wq" which doesn't have
>> the WQ_UNBOUND flag to handle all its work items. Fix this violation of
>> latency limits by using "system_unbound_wq" in the RCU core instead.
>> This will ensure that those work items will not be run on CPUs marked
>> as isolated.
>>
> Alternative approach here could be, in case we want to keep per CPU worker
> pools, define a wq with WQ_CPU_INTENSIVE flag. Are there cases where
> WQ_CPU_INTENSIVE wq won't be sufficient for the problem this patch
> is fixing?

What exactly will we gain by defining a WQ_CPU_INTENSIVE workqueue? Or 
what will we lose by using system_unbound_wq? All the calls that are 
modified to use system_unbound_wq are using WORK_CPU_UNBOUND as their 
cpu. IOW, they doesn't care which CPUs are used to run the work items. 
The only downside I can see is the possible loss of some cache locality.

In fact, WQ_CPU_INTENSIVE can be considered a subset of WQ_UNBOUND. An 
WQ_UNBOUND workqueue will avoid using isolated CPUs, but not a 
WQ_CPU_INTENSIVE workqueue.

Cheers,
Longman


