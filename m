Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6B333DF;
	Thu,  3 Jul 2025 01:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751504680; cv=none; b=ho3kH9P9svGTCZzsk/jjTXkTy7wQ9y2PBhnq3mRZ8LKlVcm7vRj26BSI9TCYQ1Yx22HZYX5VpljJHbTe8zIjVx8q1XbcEFHnKToZkwkmhwN/mdlmEq49Zc+Mgj7hbFMt1n73yLpw/rdW016ZxKeNb0DdHO3xwgDDwIxLpUw+u74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751504680; c=relaxed/simple;
	bh=JlAOZZjzEGS5FPV5Oiqzo/4Njn+txUSWp1s0aZkR5iY=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=R0JiBks/6Vj5enkisqXKnkygWrJMDuxCv2zzchiW7J+/nDz87tUvt7dKhZ24JsUBdr3M+aSZVMkkejka27kR3XseJfAwAkUGi8Vx4XskvAu/W30aq/pdGx7iivR5w87k7LBztjIWovPKDi+FHyS75e7Qv0WA2oxCq+2aUTugmoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bXdm56rNkz2TSmQ;
	Thu,  3 Jul 2025 09:02:45 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 1A6FA14022E;
	Thu,  3 Jul 2025 09:04:33 +0800 (CST)
Received: from kwepemq500009.china.huawei.com (7.202.195.53) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 3 Jul 2025 09:04:32 +0800
Received: from [10.174.179.5] (10.174.179.5) by kwepemq500009.china.huawei.com
 (7.202.195.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 3 Jul
 2025 09:04:31 +0800
Subject: Re: [QUESTION] problems report: rcu_read_unlock_special() called in
 irq_exit() causes dead loop
To: Joel Fernandes <joelagnelf@nvidia.com>, Qi Xi <xiqi2@huawei.com>,
	<paulmck@kernel.org>
CC: Joel Fernandes <joel@joelfernandes.org>, <ankur.a.arora@oracle.com>,
	Frederic Weisbecker <frederic@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	<neeraj.upadhyay@kernel.org>, <urezki@gmail.com>, <rcu@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Wangshaobo (bobo)"
	<bobo.shaobowang@huawei.com>, Xie XiuQi <xiexiuqi@huawei.com>
References: <9acd5f9f-6732-7701-6880-4b51190aa070@huawei.com>
 <CAEXW_YRC=f6i3KOd_uhuH=xAOCG7mW7-LwtA4+_fc8FMjfRHeg@mail.gmail.com>
 <3ce6f3ce-5dfb-8c59-cb7b-4619b70f8d25@huawei.com>
 <20250603185939.GA1109523@joelnvbox>
 <066e8121-c6c5-48ac-b35a-e6430d986dff@nvidia.com>
 <a82784fd-d51e-4ea2-9d5c-43db971a3074@nvidia.com>
 <c448118b-9f7e-4c29-d6b3-a66e70f7163f@huawei.com>
 <a963b475-72cd-474d-96d4-9e651fc8f857@paulmck-laptop>
 <e7354668-2573-4564-834b-44d76d983222@nvidia.com>
 <09e4d018-3db4-404e-a8f0-041cdee15a62@huawei.com>
 <279d2f06-d4f7-46e1-9678-999a2d19b710@nvidia.com>
 <506d8c4e-c317-4c85-9bcf-695596551d28@huawei.com>
 <166bc5aa-a715-438e-8805-c74c2b5fc83b@nvidia.com>
 <c16ddb6e-73f1-4eff-bbcf-c03b95f79fdf@nvidia.com>
From: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <8f5925c1-9553-63d3-d5a0-387c2395963d@huawei.com>
Date: Thu, 3 Jul 2025 09:04:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c16ddb6e-73f1-4eff-bbcf-c03b95f79fdf@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemq500009.china.huawei.com (7.202.195.53)



On 2025/7/3 1:24, Joel Fernandes wrote:
> 
> 
> On 7/2/2025 6:59 AM, Joel Fernandes wrote:
>>
>>
>> On 7/2/2025 5:14 AM, Qi Xi wrote:
>>> Hi Joel,
>>>
>>> After applying the 2 patches, the problem still exists. Compared to the previous
>>> fixes which did solve the problem, the difference is ct_in_irq() in the first
>>> patch.
>>>
>>> I am wondering why "nesting != CT_NESTING_IRQ_NONIDLE" is added?
>>>
>>>
>>> (previous fix: problem is solved)
>>>
>>> +bool ct_in_irq(void)
>>> +{
>>> +    return ct_nmi_nesting() != 0;
>>> +}
>>>
>>> (current fix: problem still exists)
>>>
>>> +bool ct_in_irq(void)
>>> +{
>>> +    long nesting = ct_nmi_nesting();
>>> +
>>> +    return (nesting && nesting != CT_NESTING_IRQ_NONIDLE);
>>> +}
>>
>> Oh gosh, thanks for spotting that! Indeed,  I had changed it to != 0 in the last
>> version but applied an older patch. I will fix it in the tree. Thank you again!
>>
>> Neeraj, would you like this as a separate commit that you can then squash? Or
>> could you fix it up in your tree?
>>
> Qi, Xiongfeng, I am currently working on alternative fix after discussing with
> the crew. I will keep you posted with the fix, and would it to be good to get
> your testing on it once I have it (hopefully in couple of days), thanks for the
> report!

Sure, we are glad to help test once we get the fix patch.

Thanks,
Xiongfeng

> 
>  - Joel
> 
> .
> 
