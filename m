Return-Path: <SRS0=IIpI=S2=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59138C10F11
	for <rcu@archiver.kernel.org>; Wed, 24 Apr 2019 18:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FEA6218FE
	for <rcu@archiver.kernel.org>; Wed, 24 Apr 2019 18:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387665AbfDXSas (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:30:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58032 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733265AbfDXSar (ORCPT
        <rfc822;rcu@vger.kernel.org>); Wed, 24 Apr 2019 14:30:47 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OISqIK073143
        for <rcu@vger.kernel.org>; Wed, 24 Apr 2019 14:30:46 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s2v4wap6s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <rcu@vger.kernel.org>; Wed, 24 Apr 2019 14:30:46 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <rcu@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 24 Apr 2019 19:30:45 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 24 Apr 2019 19:30:41 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3OIUeGR20971672
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Apr 2019 18:30:40 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DC3EB2066;
        Wed, 24 Apr 2019 18:30:40 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F874B205F;
        Wed, 24 Apr 2019 18:30:40 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.231.45])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 24 Apr 2019 18:30:40 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E3E5F16C5ED1; Wed, 24 Apr 2019 11:30:39 -0700 (PDT)
Date:   Wed, 24 Apr 2019 11:30:39 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kselftest@vger.kernel.org, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] rcutorture: Tweak kvm options
Reply-To: paulmck@linux.ibm.com
References: <20190424073446.8577-1-bigeasy@linutronix.de>
 <20190424103809.GM3923@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424103809.GM3923@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19042418-0064-0000-0000-000003D07548
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010988; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01193812; UDB=6.00625852; IPR=6.00974635;
 MB=3.00026579; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-24 18:30:43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042418-0065-0000-0000-00003D30CBD3
Message-Id: <20190424183039.GA4494@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904240133
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Apr 24, 2019 at 03:38:09AM -0700, Paul E. McKenney wrote:
> On Wed, Apr 24, 2019 at 09:34:46AM +0200, Sebastian Andrzej Siewior wrote:
> > In one of my rcutorture tests the TSC clocksource got marked unstable
> > due to a large difference in the TSC value. I'm not sure if the guest
> > run for a long time with disabled interrupts or if the host was very
> > busy and didn't schedule the guest for some time.
> > I took a look on the qemu/KVM options and decided to update the options:
> > - Use kvm{32|64} as CPU. We could probably use `host' (like ARM does)
> >   for maximum available features but since we don't run any userland I'm
> >   not sure if it makes any difference.
> > 
> > - Drop the "noapic" option, enable TSC deadline timer. There is no
> >   history why the APIC was disabled, I see no reason for it. The
> >   deadline timer is probably "nicer".
> > 
> > - Additional config options. It ensures that the kernel knowns that it
> >   runs as a kvm guest and can use virt devices like the kvm-clock as
> >   clocksource. The kvm-clock was the main motivation here.
> > 
> > - I didn't add a random HW device. It would make the random device ready
> >   earlier (not it doesn't complete the initialisation at all) but I
> >   doubt that there is any need for this.
> > 
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> Thank you, Sebastian!  Queued for review and testing.

And it doesn't like my (admittedly ancient) QEMU, complaining about not
knowing about "x2apic=on,tsc-deadline=on,hypervisor=on,tsc_adjust=on".
If I remove these, it works.  I will be upgrading soon (famous last
words), so what I am going to do is queue the following separate
not-for-upstream patch that makes it work on my setup.

							Thanx, Paul

------------------------------------------------------------------------

commit d33dffe7d1f05adfc798836a9d30b9f6bf69635d
Author: Paul E. McKenney <paulmck@linux.ibm.com>
Date:   Wed Apr 24 05:20:07 2019 -0700

    EXP torture: Hack patch to support ancient QEMU
    
    To be removed before upstreaming or when Paul gets his QEMU act together,
    whichever comes first.  ;-)
    
    Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>

diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
index be3c5c73d7e7..c3a49fb4d6f6 100644
--- a/tools/testing/selftests/rcutorture/bin/functions.sh
+++ b/tools/testing/selftests/rcutorture/bin/functions.sh
@@ -203,7 +203,7 @@ identify_qemu_args () {
 	case "$1" in
 	qemu-system-x86_64|qemu-system-i386)
 		echo -machine q35,accel=kvm
-		echo -cpu ${KVM_CPU},x2apic=on,tsc-deadline=on,hypervisor=on,tsc_adjust=on
+		echo -cpu ${KVM_CPU}
 		;;
 	qemu-system-aarch64)
 		echo -machine virt,gic-version=host -cpu host

