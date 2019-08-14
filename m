Return-Path: <SRS0=j199=WK=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=BIGNUM_EMAILS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69B2C433FF
	for <rcu@archiver.kernel.org>; Wed, 14 Aug 2019 12:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F9B2084D
	for <rcu@archiver.kernel.org>; Wed, 14 Aug 2019 12:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbfHNM31 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 14 Aug 2019 08:29:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53378 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725800AbfHNM31 (ORCPT
        <rfc822;rcu@vger.kernel.org>); Wed, 14 Aug 2019 08:29:27 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7ECOxwS035975;
        Wed, 14 Aug 2019 08:29:23 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ucj9p05kx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Aug 2019 08:29:23 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7ECS0Vj027044;
        Wed, 14 Aug 2019 12:29:22 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma02dal.us.ibm.com with ESMTP id 2u9nj6518v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Aug 2019 12:29:22 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7ECTMh154985042
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Aug 2019 12:29:22 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E74AB2064;
        Wed, 14 Aug 2019 12:29:22 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2513B205F;
        Wed, 14 Aug 2019 12:29:21 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.180.63])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 14 Aug 2019 12:29:21 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 51C1F16C12A4; Wed, 14 Aug 2019 05:29:22 -0700 (PDT)
Date:   Wed, 14 Aug 2019 05:29:22 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     rcu@vger.kernel.org
Subject: Re: [bug report] rcu/nocb: Add bypass callback queueing
Message-ID: <20190814122922.GQ28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190814103839.GA12599@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814103839.GA12599@mwanda>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-14_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=805 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908140129
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Aug 14, 2019 at 01:38:39PM +0300, Dan Carpenter wrote:
> Hello Paul E. McKenney,
> 
> The patch 1afc4b18724f: "rcu/nocb: Add bypass callback queueing" from
> Jul 2, 2019, leads to the following static checker warning:
> 
> 	kernel/rcu/tree_plugin.h:1792 rcu_nocb_try_bypass()
> 	warn: unsigned 'c' is never less than zero.

Good catch, but Coverity and Colin Ian King beat you to it.  The alleged
fixed commit may be found on -rcu at d1b222c6be1f ("rcu/nocb: Add bypass
callback queueing").

							Thanx, Paul

> kernel/rcu/tree_plugin.h
>   1761  static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>   1762                                  bool *was_alldone, unsigned long flags)
>   1763  {
>   1764          unsigned long c;
>                 ^^^^^^^^^^^^^^^
>   1765          unsigned long cur_gp_seq;
>   1766          unsigned long j = jiffies;
>   1767          long ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
>   1768  
>   1769          if (!rcu_segcblist_is_offloaded(&rdp->cblist)) {
>   1770                  *was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
>   1771                  return false; /* Not offloaded, no bypassing. */
>   1772          }
>   1773          lockdep_assert_irqs_disabled();
>   1774  
>   1775          // Don't use ->nocb_bypass during early boot.
>   1776          if (rcu_scheduler_active != RCU_SCHEDULER_RUNNING) {
>   1777                  rcu_nocb_lock(rdp);
>   1778                  WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
>   1779                  *was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
>   1780                  return false;
>   1781          }
>   1782  
>   1783          // If we have advanced to a new jiffy, reset counts to allow
>   1784          // moving back from ->nocb_bypass to ->cblist.
>   1785          if (j == rdp->nocb_nobypass_last) {
>   1786                  c = rdp->nocb_nobypass_count + 1;
>   1787          } else {
>   1788                  WRITE_ONCE(rdp->nocb_nobypass_last, j);
>   1789                  c = rdp->nocb_nobypass_count - nocb_nobypass_lim_per_jiffy;
>   1790                  if (c > nocb_nobypass_lim_per_jiffy)
>   1791                          c = nocb_nobypass_lim_per_jiffy;
>   1792                  else if (c < 0)
>                                  ^^^^^
> Impossible!
> 
>   1793                          c = 0;
>   1794          }
> 
> regards,
> dan carpenter
> 
