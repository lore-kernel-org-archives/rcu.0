Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58758265CC8;
	Tue,  1 Jul 2025 09:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751361659; cv=none; b=eEk9zUnPBo3mzAdRWznMBT0+YPWMPeyHTutB78Ss/dRMyNjSp7GtNFqr2MZjKz20rI4ox/qX9r+Wa8vAouvI6Kdm+F9dV/ozhxapmS/rn8n79FmY0jhKMBokTnZtNG81GIs43qjRf5J2/5rpx3N/OF2tVpimGp4kE2nxSffXgYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751361659; c=relaxed/simple;
	bh=P3XzVml8VOYHlwM4nPlymyPxhWlJy6Gon8cEG/DVKTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iRMpuYEuD9nTxrlmAb2ooSBZig4XzIZtcWplrQpzRHlyT4Np9PptTf687G/ClPYahz/DH5twZkLVcKw2W8PzMVc78VYfrFMs9yjXpOy3cio1Kz0ynrbjcd+C8FfSnynWgHS/mnhua1PW7TJFC/6LdFrpE/PBXF5qN6Ul6ZDXuK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bWcpc59kdzWfv4;
	Tue,  1 Jul 2025 17:16:24 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id E15A51402CF;
	Tue,  1 Jul 2025 17:20:46 +0800 (CST)
Received: from kwepemn200010.china.huawei.com (7.202.194.133) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 1 Jul 2025 17:20:46 +0800
Received: from [10.174.178.56] (10.174.178.56) by
 kwepemn200010.china.huawei.com (7.202.194.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 1 Jul 2025 17:20:45 +0800
Message-ID: <09e4d018-3db4-404e-a8f0-041cdee15a62@huawei.com>
Date: Tue, 1 Jul 2025 17:20:45 +0800
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QUESTION] problems report: rcu_read_unlock_special() called in
 irq_exit() causes dead loop
To: Joel Fernandes <joelagnelf@nvidia.com>, <paulmck@kernel.org>, "Xiongfeng
 Wang" <wangxiongfeng2@huawei.com>
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
Content-Language: en-GB
From: Qi Xi <xiqi2@huawei.com>
In-Reply-To: <e7354668-2573-4564-834b-44d76d983222@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemn200010.china.huawei.com (7.202.194.133)

Hello everyone,

Friendly ping about this problem :)

Qi

On 2025/6/6 2:56, Joel Fernandes wrote:
>
> On 6/4/2025 8:26 AM, Paul E. McKenney wrote:
>>>>>>>> Or just don't send subsequent self-IPIs if we just sent one for the
>>>>>>>> rdp. Chances are, if we did not get the scheduler's attention during
>>>>>>>> the first one, we may not in subsequent ones I think. Plus we do send
>>>>>>>> other IPIs already if the grace period was over extended (from the FQS
>>>>>>>> loop), maybe we can tweak that?
>>>>>>> Thanks a lot for your reply. I think it's hard for me to fix this issue as
>>>>>>> above without introducing new bugs. I barely understand the RCU code. But I'm
>>>>>>> very glad to help test if you have any code modifiction need to. I have
>>>>>>> the VM and the syskaller benchmark which can reproduce the problem.
>>>>>> Sure, I understand. This is already incredibly valuable so thank you again.
>>>>>> Will request for your testing help soon. I also have a test module now which
>>>>>> can sort-off reproduce this. Keep you posted!
>>>>> Oh sorry I meant to ask - could you provide the full kernel log and also is
>>>>> there a standalone reproducer syzcaller binary one can run to reproduce it in a VM?
>>> Sorry, I communicate with the teams who maintain the syzkaller tools. He said
>>> I can't send the syskaller binary out of the company. Sorry, but I can help to
>>> reproduce. It's not complicate and not time consuming.
>>>
>>> I found the origin log which use kernel v6.6. But it's not complete.
>>> Then I reprouce the problem using the latest kernel.
>>> Both logs are attached as attachments.
>>>
>> Looking at both the v6.6 version and Joel's fix, I am forced to conclude
>> that this bug has been there for a very long time.  Thank you for your
>> testing efforts and Joel for the fix!
> Thanks. I am still working on polishing the fix Xiongfeng tested. I hope to have
> it out next week for review. As we discussed I will split the context-tracking
> API into a separate patch and will also add a separate documentation
> comment-patch on why we need the irq_work.
>
> thanks,
>
>   - Joel
