Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,BIGNUM_EMAILS,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821A2C433E6
	for <rcu@archiver.kernel.org>; Tue, 12 Jan 2021 14:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CF0A23121
	for <rcu@archiver.kernel.org>; Tue, 12 Jan 2021 14:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbhALOoh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 12 Jan 2021 09:44:37 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:38620 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbhALOog (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 12 Jan 2021 09:44:36 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CEhlsG175618;
        Tue, 12 Jan 2021 14:43:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=79cSaJzJ2MNjI8Id9X8ccmR+yaUkWnFPgSYCyVOWIZA=;
 b=t0VtmXPuJww7qJlfJH2wZrvPIHEdO3Vyg+NkXTaBvOFsStMi7nAM6GWywZqbiAiQC8F0
 vNvl4p4L00F9Trj5Wbq7n0D8sTkDM5QptWDiqzOun2UWaGnXBw7IwDQ5gBJPPYZyj6kh
 ErCt3OMoho3kLdl32Ev7RtsGSHgSPhMrBbSct19LdG75pttPo5FF//giUVRzXBMMoqrv
 Khb1GyXkKWtnzkMh4kbPW2/vmZW2zaNKqAl/8LCcwigBU6hp8z01ostbP8ey2wzAOkIw
 kZgrToiccEUmYz8nQvKRzhXkE6/VVjQMa/vbpH8/OhyXp46CRq/k3kuNx+GgAmU+athL Ww== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 360kcypmru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 14:43:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CEZXYO180620;
        Tue, 12 Jan 2021 14:41:53 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 360ke6kr2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 14:41:53 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10CEfrmW005691;
        Tue, 12 Jan 2021 14:41:53 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 06:41:52 -0800
Date:   Tue, 12 Jan 2021 17:41:46 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org
Subject: [bug report] EXP rcuscale: Add crude tests for mem_dump_obj()
Message-ID: <X/21KmJ1+jW+PJjC@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9861 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=881 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101120084
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9861 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1011 mlxlogscore=886 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120085
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello Paul E. McKenney,

The patch b3a539cc4d37: "EXP rcuscale: Add crude tests for
mem_dump_obj()" from Dec 7, 2020, leads to the following static
checker warning:

	kernel/rcu/rcutorture.c:1888 rcu_torture_stats()
	warn: did you mean to pass the address of 'rhp'

kernel/rcu/rcutorture.c
  1865          {
  1866                  struct rcu_head *rhp;
  1867                  struct kmem_cache *kcp;
  1868                  static int z;
  1869  
  1870                  kcp = kmem_cache_create("rcuscale", 136, 8, SLAB_STORE_USER, NULL);
  1871                  rhp = kmem_cache_alloc(kcp, GFP_KERNEL);
  1872                  pr_alert("mem_dump_obj() slab test: rcu_torture_stats = %px, &rhp = %px, rhp = %px, &z = %px\n", stats_task, &rhp, rhp, &z);
                                                                                                                                     ^^^^
Hopefully the address of rhp doesn't change at all in this function 0_0!

  1873                  pr_alert("mem_dump_obj(ZERO_SIZE_PTR):");
  1874                  mem_dump_obj(ZERO_SIZE_PTR);
  1875                  pr_alert("mem_dump_obj(NULL):");
  1876                  mem_dump_obj(NULL);
  1877                  pr_alert("mem_dump_obj(%px):", &rhp);
  1878                  mem_dump_obj(&rhp);
  1879                  pr_alert("mem_dump_obj(%px):", rhp);
  1880                  mem_dump_obj(rhp);
  1881                  pr_alert("mem_dump_obj(%px):", &rhp->func);
  1882                  mem_dump_obj(&rhp->func);
  1883                  pr_alert("mem_dump_obj(%px):", &z);
  1884                  mem_dump_obj(&z);
  1885                  kmem_cache_free(kcp, rhp);
  1886                  kmem_cache_destroy(kcp);
  1887                  rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
  1888                  pr_alert("mem_dump_obj() kmalloc test: rcu_torture_stats = %px, &rhp = %px, rhp = %px\n", stats_task, &rhp, rhp);
  1889                  pr_alert("mem_dump_obj(kmalloc %px):", rhp);
  1890                  mem_dump_obj(rhp);
  1891                  pr_alert("mem_dump_obj(kmalloc %px):", &rhp->func);
  1892                  mem_dump_obj(&rhp->func);
  1893                  kfree(rhp);
  1894                  rhp = vmalloc(4096);
  1895                  pr_alert("mem_dump_obj() vmalloc test: rcu_torture_stats = %px, &rhp = %px, rhp = %px\n", stats_task, &rhp, rhp);
  1896                  pr_alert("mem_dump_obj(vmalloc %px):", rhp);
  1897                  mem_dump_obj(rhp);
  1898                  pr_alert("mem_dump_obj(vmalloc %px):", &rhp->func);
  1899                  mem_dump_obj(&rhp->func);
  1900                  vfree(rhp);
  1901          }

regards,
dan carpenter
