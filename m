Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620D32E11C7;
	Tue, 21 Jul 2026 04:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784608347; cv=none; b=SrEhynjwFCO3d/NyLgvoCAL53GbsU5FPbznvCxS3hYFNLQu4wXxRXkHVGRpY2Rc9xmZh27Ju84ATNd1lTPC/aMjDKwzzcq1tzTkMApiTTxNMgVFWzJLXPyfS184oFTDxZQST4vVRDtph5bJCH3uibKiKCj28vR0vMhEYAnapNpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784608347; c=relaxed/simple;
	bh=yZQ10iSoaK9L6P2H8/15hgX0b2hyDhwWswO/9Vi/IpY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Zuxj0VskI+hWv2BevBGUaYHN+J9gVfKlHIBYk6GWDVFWup/IWomVGqLHPGsE3aFWhIb8FUB4su8EDYq5/Z/B6RPd1+IY5FTCTNkDzKnPM41KFwtkE9ysuKOtuIuJUaSPAOyCbC++W1ef+ci3A2aOXlxXTeZZpRwELJ1P6Xj8o2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WFIjxfGL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WFIjxfGL"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KNDELk3479563;
	Tue, 21 Jul 2026 04:31:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Cp0Lkf
	sIDWF99aD1jwAoR7glD5wjBpQ35RSdHNflOfY=; b=WFIjxfGLTVlSg60qBc7clI
	24GhmyiCo3ge8d9uECjPFF9c54zYBzJ5J2RiL3XCR8HG6S+JBqihTQylpm9ewr78
	4RhjsNhWLNK1UVH3xuhXH/BW04cUpjOTtrNy/DnhBcogsCu6kWe1qJpXiPrQNKq+
	vDGboH1Mwsyv/GN8vi0DFnTqPZ/4AfbIBQvPY1iBKbYirDVRpuV08rnqulKcRWnW
	yLCh5Nw+zvmb3KI1X82L9M98vrT46HyaoJvDpi90QBoa3UkAfVEv9KrmZi2ZQn3v
	npz/UHKH5kDJyPkbOSnjG06ghcqxXUfjOEOceM5rXW/b8Jw9KIa2XINnrNN6tmUg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77k2gk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 04:31:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66L4Jg61005590;
	Tue, 21 Jul 2026 04:31:56 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtjrq5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 04:31:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66L4VqJw48955678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jul 2026 04:31:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9F4E20043;
	Tue, 21 Jul 2026 04:31:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1125B2004B;
	Tue, 21 Jul 2026 04:31:49 +0000 (GMT)
Received: from [9.39.17.99] (unknown [9.39.17.99])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Jul 2026 04:31:48 +0000 (GMT)
Message-ID: <e143d10e-69b1-455d-90b3-5f29a9482c15@linux.ibm.com>
Date: Tue, 21 Jul 2026 10:01:34 +0530
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] cpuhp: Expedite RCU when toggling system-wide SMT
 mode
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: paulmck@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, aboorvad@linux.ibm.com,
        boqun.feng@gmail.com, frederic@kernel.org, joelagnelf@nvidia.com,
        josh@joshtriplett.org, neeraj.upadhyay@kernel.org, rostedt@goodmis.org,
        srikar@linux.ibm.com, urezki@gmail.com,
        Vishal Chourasia <vishalc@linux.ibm.com>, samir@linux.ibm.com
References: <20260615042514.694993-2-vishalc@linux.ibm.com>
 <20260615042514.694993-4-vishalc@linux.ibm.com>
 <f1a04d2f-367e-4be8-b313-31a73e15bcd0@paulmck-laptop>
 <4bd12c51-414d-49b5-8fce-2a6e73a479fa@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <4bd12c51-414d-49b5-8fce-2a6e73a479fa@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a5ef63d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=ZqOttr7FMA8WdoUQ5m8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA0MCBTYWx0ZWRfX5ZqvZl+SrCxZ
 5ZNINNNKUCTCTTRiIFfPmbhEP9XysGCjSsqjmxF5VbRXOdktOxaafMFyfBoumQiJBl8rYPTM4Th
 sVqyhsIyCaLGHBXuzR+DScwRoU82F2M4Fqkp8rrzT/vSZ47gFwEadGbZT+nVt25emDmCz1aDsH0
 8DqJD2a3OqLe3G4ILf3+Jdy+WzDk1pKU6GiuurUHIhOgrsJzw0oDKIAQovPIcUIqOVNYELZqBei
 NpgsfGln/2j1O5pN85x0nTEP64G+MbCfVEJwVEUjCQCgUR/dkNdX8Y5BC19Fhv6iI3vcExGZvda
 rr97SierZJ1xCULnhp5FlW597/pDD8UCRgC6YULG6VJMf4USE/aEntgXXBh/dfqrSCXMbXYsLNr
 MbWAE5cAnVgbJCYDJDBCmMJV2ou2YYEIG1T2b9acqmZ3aSHYqgReGqrK6UAHcRINhkJNfPCZKWs
 8YIax6HbL3B4bUwOvjA==
X-Proofpoint-ORIG-GUID: 4fFJY9S0K9nugp0_l1IW4-cDa9E-fFil
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA0MCBTYWx0ZWRfX0oqp2t+m2FRD
 CWjTS96BnTg2/v/jsc2G7hHxo4TrxAhC0Csd80VxxXDxBTVIpeqDC1wW9zZ2IjbxN5ovElaWgXp
 f39iQO9yLhYs7pviiICY8oQOWD1umRY=
X-Proofpoint-GUID: BxrJPxiLo3B26SGzZQmXiWpbnXUKsype
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210040



On 6/16/26 11:39 AM, Shrikanth Hegde wrote:
> 
> 

>>>
>>> On a large config system with 1920 CPUs, completion time improves from
>>> ~1 hour to 5-6 minutes.
>>>
>>> Tested-by: Samir <samir@linux.ibm.com>
>>> Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>>> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
>>
>>  From an RCU viewpoint:
>>
>> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Thank you Paul for reviewing this.
> 
>>
>> I am guessing that you will be taking this up some other path, but if
>> you would like it to to via RCU, please let me know.
>>
>>                             Thanx, Paul
>>
> 
> I would prefer this to go via tip tree since main change is in cpu.c
> 
> Thomas, peter,
> What do you guys suggest? can this go via tip tree?
> 
> Also, do you have any other review comments on this or test to be done?
>

Gentle Ping.

Thomas, Peter, Ingo, Can this go via tip tree?
Do you guys have any comments to be addressed?

Or Do you want it to go via RCU tree?

