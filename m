Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D3DC4167B
	for <rcu@archiver.kernel.org>; Thu, 22 Dec 2022 11:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbiLVLe3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 22 Dec 2022 06:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbiLVLe2 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 22 Dec 2022 06:34:28 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7D61116B
        for <rcu@vger.kernel.org>; Thu, 22 Dec 2022 03:34:27 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BMAd30P016595
        for <rcu@vger.kernel.org>; Thu, 22 Dec 2022 11:34:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : to : from : cc : subject : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=uoFeOnVuTd5BVqFbg2YJQ9AObzE5s5nMs36gm+rTnWE=;
 b=QnOp97v1IneQfrkt8008IxWAQvhYnsrOZM5T89/Edrt3zJRfOUEz/rCOysA2LI3fT+SB
 biRK88VqXAhXGbZW8P1vJubUQ34a2ZZUxXBqHBpvqpH82HSa4iR9GGZ9W31zcC+0ep90
 8xVEz05XVppD6mN7ivL8Ie2rF3voGeSgSxNKeT2d4iwStc4Nj3zs2/nb2kxHReh5NPap
 RqS6QnPA1CypmNRLIScefJi2CKwPHKofGN9nzDULPFfDBqlnReYVVMNUSiPWAbCS6aX/
 nQF6wHrHiWV5GRKMg8Pnt+R/oDvYqqf74ONYCDTOfW5lmbWZjdHkUGGp64v1l85Yi/SK ng== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mm5r2j0kt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <rcu@vger.kernel.org>; Thu, 22 Dec 2022 11:34:27 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BMBYQRT010059
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <rcu@vger.kernel.org>; Thu, 22 Dec 2022 11:34:26 GMT
Received: from [10.216.26.128] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 22 Dec
 2022 03:34:25 -0800
Message-ID: <0fc6b3b3-465b-0b64-fbdf-c80db18a9f88@quicinc.com>
Date:   Thu, 22 Dec 2022 17:04:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Content-Language: en-US
To:     <rcu@vger.kernel.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
CC:     <quic_mojha@quicinc.com>
Subject: NULL pointer issue in rcu_do_batch()
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: c4R4HsTQP6OftMkoAkUPnK97HXl-wti9
X-Proofpoint-ORIG-GUID: c4R4HsTQP6OftMkoAkUPnK97HXl-wti9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-22_05,2022-12-22_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=660 malwarescore=0 bulkscore=0
 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212220100
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi All,

We are observing NULL pointer dereference issue in rcu_do_batch() in 
5.15, although it is very hard to hit.

Wanted to check if it is been reported and fixed in recent kernel ?


<1>[16.814014] [pid:    58] Unable to handle kernel NULL pointer 
dereference at virtual address 0000000000000000
<0>[16.814027] [pid:    58] PC Code: bad value
<0>[16.814034] [pid:    58] LR Code: f81e03a8 b5000068 d10083a8 f81e83a8 
aa1f03f6 91127319 d10083b7 f9434b68 d503201f f9400408 910006d6 f900041f 
d63f0100 (91004308) b8bfc108 374001c8 97ffff2b 9111e308 38bfc108 72001d1f

<4>[16.814359] [pid:    58] CPU: 7 PID: 58 Comm: rcuop/5 Tainted: G S 
   W  OE     5.15.41-android13-8-25574579-abS911USQU1AVLL #1
<4>[16.814361] [pid:    58] Hardware name: XXXXX
<4>[16.814362] [pid:    58] pstate: 42400805 (nZcv daif +PAN -UAO +TCO 
-DIT -SSBS BTYPE=-c)
<4>[16.814364] [pid:    58] pc : 0x0
<4>[16.814365] [pid:    58] lr : rcu_do_batch+0x328/0xcd8


rcu_data for CPU5 contains additional 12 RCU callback heads in the 
segment of RCU_DONE_TAIL whose func is NULL. It doesn’t seem to be a 
random memory corruption since only rhp->func is set to null across 
multiple objects.

There is one more occurrence with CONFIG_CFI_CLANG enabled.

[123587.101222][   T44] Kernel panic - not syncing: CFI failure (target: 
0x0)
[123587.101249][   T44] CPU: 0 PID: 44 Comm: rcuop/3 Tainted: G S 
WC OE     5.15.41 #1
[123587.101263][   T44] Hardware name: XXXXX
[123587.101274][   T44] Call trace:
[123587.101283][   T44]  dump_backtrace.cfi_jt+0x0/0x8
[123587.101298][   T44]  show_stack+0x1c/0x2c
[123587.101311][   T44]  dump_stack_lvl+0x94/0x100
[123587.101326][   T44]  panic+0x17c/0x450
[123587.101338][   T44]  find_check_fn+0x0/0x210
[123587.101349][   T44]  rcu_do_batch+0x368/0x6f8
[123587.101362][   T44]  nocb_cb_wait+0x80/0x450
[123587.101374][   T44]  rcu_nocb_cb_kthread+0x54/0x90
[123587.101386][   T44]  kthread+0x174/0x1d8
[123587.101398][   T44]  ret_from_fork+0x10/0x20
[123587.101410][   T44] SMP: stopping secondary CPUs
[123587.101670][    C4] VendorHooks: CPU4: stopping

-Mukesh
