Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C1D2874FB;
	Mon, 19 Jan 2026 13:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768830336; cv=none; b=QnkZAzVof2C4MAyuUfiv0Ex9DIztnw8jsyyNNJTxt46KyzIm1EEk4jZfN63IqpDeRDOjRhgeHAKdeFXeaYajoAd8BKUHSnPI7IRxpRhvjG8AwvSbQOKht56ADeJKM6KmssYa3loVbx/cHSxB9OkLZm4oZPeMqwPeNgv1JRDC5ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768830336; c=relaxed/simple;
	bh=pdY4cqICHcU2/Ccd76FJrNsaqxJGeMT9PL+pHAyEkpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k0GX05ES3nYiDGXChg47gLv6cuddxWh0GpWDAwDw1RMI1/QWH4mdMod1//u/Voj6d07PRMtnXOvB3iqPGYIAB3y3KYqzkBLYOKnhGIPVSGGRfNIEt8klWG2MQkbotj/wIAz3Nq/yCY7ChdlsY+DJdYmPTCdiAQV5WOzfIseXkEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iqbgU4it; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iqbgU4it"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60J7XkOO004245;
	Mon, 19 Jan 2026 13:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SLL16W
	8P8j6/AGpWKUD68CygUPEsDMD78wpUaV7oiz4=; b=iqbgU4itLIU1Qyks66e5bf
	hmTOzc2XP86c+1Lvehjz2nSXMGJRbxvOAf7OrNKmXVOoER3tpwCCe29RHQXAfGty
	zUWrIxso4ebRjSp3F3EEdG9RSUxSIP7DbfKhIHgcHEbsr9W4rqw1z75lNAF/WtkJ
	zK7VtCvCyzK/8T/NYfpYjjRiMwRAXTannncViqnZ4tP1I8j3eeCdUGyvK8XRMNMQ
	+3riFVeO+lA3M0di5vo/F+z7jtv9bv5hfg48jceONStu5xMOXVWP/ziXhSYWaqLP
	Y8R8mIslrYtkhw89dKCrtUEBA3lvAzqzm3D+RVmK65lpJuiAgedPKGH2os5J1WNg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br0uf7yj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 13:45:18 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60JDaZIV026812;
	Mon, 19 Jan 2026 13:45:18 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br0uf7yj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 13:45:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60JBCHOs001168;
	Mon, 19 Jan 2026 13:45:17 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brpyjeqvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 13:45:17 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60JDjDuF49742216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 13:45:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB2DC2004B;
	Mon, 19 Jan 2026 13:45:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C116420040;
	Mon, 19 Jan 2026 13:45:10 +0000 (GMT)
Received: from [9.124.220.45] (unknown [9.124.220.45])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Jan 2026 13:45:10 +0000 (GMT)
Message-ID: <88f03a33-133f-44dd-bd49-395d4fa754d6@linux.ibm.com>
Date: Mon, 19 Jan 2026 19:15:09 +0530
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuhp: Expedite synchronize_rcu during SMT switch
To: Peter Zijlstra <peterz@infradead.org>,
        Vishal Chourasia <vishalc@linux.ibm.com>
Cc: boqun.feng@gmail.com, frederic@kernel.org, joelagnelf@nvidia.com,
        josh@joshtriplett.org, linux-kernel@vger.kernel.org,
        neeraj.upadhyay@kernel.org, paulmck@kernel.org, rcu@vger.kernel.org,
        rostedt@goodmis.org, srikar@linux.ibm.com, tglx@linutronix.de,
        urezki@gmail.com, samir@linux.ibm.com
References: <20260113090153.GS830755@noisy.programming.kicks-ass.net>
 <20260119104739.439799-2-vishalc@linux.ibm.com>
 <20260119114333.GI1890602@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260119114333.GI1890602@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: USaFucdIheBdrkI-CDqjmCy403pRIr_V
X-Proofpoint-ORIG-GUID: XvX8fL3ciX-H4mb_cihSCS0QF6Ey0MMs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDExMCBTYWx0ZWRfX+ZvqkGUTkmIe
 RmnqSbEHFDA2rYGSQgGn90pEUV64tTcIzWtAxyu5hG10KKr56OFGDn0GqYFuMIRptRpDd2fvTvG
 cKrbY4sTgAEqUM8UH9H3LwMilNCt9qHDn8mYq+2QKWidpSHs7Q40KIzrtaRrV26kz8RVwtSbJqm
 1oJt03SFNMR3KZf7RHn4g/n1MKpYoZKQxqIErQuwMixUoyMRaob1txGelJT4LHs6WPGpqNeQaFw
 +mt8Ic1pmFe2L3KO7V5lpvs71QnBm1z/1y6QthnL6UApLMjxiL03jCEbtkXYlE52Il1J1CVVzHf
 Qtvta7WzTdLG0cLUYS3bAIMcs91IcTZm9guC55m6uQ8UhFZd/+AQfQ5H6BvPmSpxfn99+1lZ6s/
 StMMDiFpjsn9/i5m4alxqQS3v24OxqtVfdmZflPJVPrp5cPgc7Xr91dOGC1Qlb3X2CmrFa5holz
 7di5uy/nMlPLlYA2GvA==
X-Authority-Analysis: v=2.4 cv=bopBxUai c=1 sm=1 tr=0 ts=696e356f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Siv2N4SOSaTVEqBjBL0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_03,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601190110

Hi Peter.

On 1/19/26 5:13 PM, Peter Zijlstra wrote:
> On Mon, Jan 19, 2026 at 04:17:40PM +0530, Vishal Chourasia wrote:
>> Expedite synchronize_rcu() during the cpuhp_smt_[enable|disable] path to
>> accelerate the operation.
>>
>> Bulk CPU hotplug operations—such as switching SMT modes across all
>> cores—require hotplugging multiple CPUs in rapid succession. On large
>> systems, this process takes significant time, increasing as the number
>> of CPUs to hotplug during SMT switch grows, leading to substantial
>> delays on high-core-count machines. Analysis [1] reveals that the
>> majority of this time is spent waiting for synchronize_rcu().
>>
> 
> You seem to have left out all the useful bits from your changelog again
> :/
> 
> Anyway, ISTR Joel posted a patch hoisting a lock; it was a icky, but not
> something we can't live with either.
> 
> Also, memory got jogged and I think something like the below will remove
> 2/3 of your rcu woes as well.
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 8df2d773fe3b..1365c19444b2 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -2669,6 +2669,7 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
>   	int cpu, ret = 0;
>   
>   	cpu_maps_update_begin();
> +	rcu_sync_enter(&cpu_hotplug_lock.rss);
>   	for_each_online_cpu(cpu) {
>   		if (topology_is_primary_thread(cpu))
>   			continue;
> @@ -2698,6 +2699,7 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
>   	}
>   	if (!ret)
>   		cpu_smt_control = ctrlval;
> +	rcu_sync_exit(&cpu_hotplug_lock.rss);
>   	cpu_maps_update_done();
>   	return ret;
>   }
> @@ -2715,6 +2717,7 @@ int cpuhp_smt_enable(void)
>   	int cpu, ret = 0;
>   
>   	cpu_maps_update_begin();
> +	rcu_sync_enter(&cpu_hotplug_lock.rss);
>   	cpu_smt_control = CPU_SMT_ENABLED;
>   	for_each_present_cpu(cpu) {
>   		/* Skip online CPUs and CPUs on offline nodes */
> @@ -2728,6 +2731,7 @@ int cpuhp_smt_enable(void)
>   		/* See comment in cpuhp_smt_disable() */
>   		cpuhp_online_cpu_device(cpu);
>   	}
> +	rcu_sync_exit(&cpu_hotplug_lock.rss);
>   	cpu_maps_update_done();
>   	return ret;
>   }


Currently, cpuhp_smt_[enable/disable] calls _cpu_up/_cpu_down
which does the same in cpus_write_lock/unlock. though it is per
cpu enable/disable one after another.

How hoisting this up will help?
