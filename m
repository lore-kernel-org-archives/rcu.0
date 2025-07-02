Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901D519D8A7;
	Wed,  2 Jul 2025 09:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751447075; cv=none; b=ccecAXkFG+433ZDuDo2kBPbngJLDkj49ZLakkDhEXX+Uj/DoT+zwpXuxz2JO7ZwT5hKdykvoPDjTemYXnryBUW1gm36AL7HEHbJiXKau1vSahF7/hw0D6LT8uhaKWB3w4pzH/t4FPXJad8bBAmnjv7augLMuaB8U+fKjwwRZP5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751447075; c=relaxed/simple;
	bh=kcztfJkBZkuN7XUV0CYXcYL9JZrdKKPYOBrbgy9LZO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RaZE06guKUbkH893VvqOLVSsckoSvsdk0o8UCGNJSZz7P1654IBz5YyeAMo+IRhcIPQzR/hC7dIq9AhY1KiirY/Cy/U6DhJGyQtLBL0yAH8sUaucd8h7AY1h2viAbkSsl4nSOeHKZjwXRtp9dpaGHsLyxct1QBYcahHUBKdPJAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bXDSM0c2Mz2TSrp;
	Wed,  2 Jul 2025 17:02:43 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 52FBA1A016C;
	Wed,  2 Jul 2025 17:04:29 +0800 (CST)
Received: from kwepemn200010.china.huawei.com (7.202.194.133) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 2 Jul 2025 17:04:29 +0800
Received: from [10.174.178.56] (10.174.178.56) by
 kwepemn200010.china.huawei.com (7.202.194.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 2 Jul 2025 17:04:28 +0800
Message-ID: <de7ba157-bede-4ab2-9b8a-cc63c7fafb79@huawei.com>
Date: Wed, 2 Jul 2025 17:04:27 +0800
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
 <09e4d018-3db4-404e-a8f0-041cdee15a62@huawei.com>
 <279d2f06-d4f7-46e1-9678-999a2d19b710@nvidia.com>
Content-Language: en-GB
From: Qi Xi <xiqi2@huawei.com>
In-Reply-To: <279d2f06-d4f7-46e1-9678-999a2d19b710@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemn200010.china.huawei.com (7.202.194.133)

Hi Joel,

After applying those 2 patches on the latest kernel, the problem still 
occurs. Compared to the previous version which solves this problem, the 
difference is the following:



On 2025/7/1 21:29, Joel Fernandes wrote:
>
> On 7/1/2025 5:20 AM, Qi Xi wrote:
>> Hello everyone,
>>
>> Friendly ping about this problem :)
>>
> Ah, thanks for checking. The fix is slated for kernel 6.17.
>
> If you want to test it, could you apply it in advance from the RCU tree?
>
> You need these 2:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git/commit/?h=next&id=6758c93749f8bf09b9282f100c5dd0a5c501f91c
>
> https://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git/commit/?h=next&id=3cd298bf3bb69e3bca6abfe97e1b44ffa37f3dee
>
> Thanks.
