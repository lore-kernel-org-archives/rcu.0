Return-Path: <SRS0=IIpI=S2=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC431C10F11
	for <rcu@archiver.kernel.org>; Wed, 24 Apr 2019 10:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5A8218D3
	for <rcu@archiver.kernel.org>; Wed, 24 Apr 2019 10:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfDXKiR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:38:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51462 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726859AbfDXKiR (ORCPT
        <rfc822;rcu@vger.kernel.org>); Wed, 24 Apr 2019 06:38:17 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OAXfvI122450
        for <rcu@vger.kernel.org>; Wed, 24 Apr 2019 06:38:15 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s2n2nksu7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <rcu@vger.kernel.org>; Wed, 24 Apr 2019 06:38:15 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <rcu@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 24 Apr 2019 11:38:14 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 24 Apr 2019 11:38:11 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3OAcA4N37683306
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Apr 2019 10:38:10 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F6C5B2065;
        Wed, 24 Apr 2019 10:38:10 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8553B2068;
        Wed, 24 Apr 2019 10:38:09 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.142.230])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 24 Apr 2019 10:38:09 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9E77116C062C; Wed, 24 Apr 2019 03:38:09 -0700 (PDT)
Date:   Wed, 24 Apr 2019 03:38:09 -0700
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424073446.8577-1-bigeasy@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19042410-0072-0000-0000-0000041E4148
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010986; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01193654; UDB=6.00625757; IPR=6.00974477;
 MB=3.00026575; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-24 10:38:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042410-0073-0000-0000-00004BF0B928
Message-Id: <20190424103809.GM3923@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904240088
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Apr 24, 2019 at 09:34:46AM +0200, Sebastian Andrzej Siewior wrote:
> In one of my rcutorture tests the TSC clocksource got marked unstable
> due to a large difference in the TSC value. I'm not sure if the guest
> run for a long time with disabled interrupts or if the host was very
> busy and didn't schedule the guest for some time.
> I took a look on the qemu/KVM options and decided to update the options:
> - Use kvm{32|64} as CPU. We could probably use `host' (like ARM does)
>   for maximum available features but since we don't run any userland I'm
>   not sure if it makes any difference.
> 
> - Drop the "noapic" option, enable TSC deadline timer. There is no
>   history why the APIC was disabled, I see no reason for it. The
>   deadline timer is probably "nicer".
> 
> - Additional config options. It ensures that the kernel knowns that it
>   runs as a kvm guest and can use virt devices like the kvm-clock as
>   clocksource. The kvm-clock was the main motivation here.
> 
> - I didn't add a random HW device. It would make the random device ready
>   earlier (not it doesn't complete the initialisation at all) but I
>   doubt that there is any need for this.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thank you, Sebastian!  Queued for review and testing.

							Thanx, Paul

> ---
>  tools/testing/selftests/rcutorture/bin/functions.sh | 13 ++++++++++++-
>  .../selftests/rcutorture/configs/rcu/CFcommon       |  4 ++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
> index 6bcb8b5b2ff22..be3c5c73d7e79 100644
> --- a/tools/testing/selftests/rcutorture/bin/functions.sh
> +++ b/tools/testing/selftests/rcutorture/bin/functions.sh
> @@ -172,7 +172,7 @@ identify_qemu_append () {
>  	local console=ttyS0
>  	case "$1" in
>  	qemu-system-x86_64|qemu-system-i386)
> -		echo noapic selinux=0 initcall_debug debug
> +		echo selinux=0 initcall_debug debug
>  		;;
>  	qemu-system-aarch64)
>  		console=ttyAMA0
> @@ -191,8 +191,19 @@ identify_qemu_append () {
>  # Output arguments for qemu arguments based on the TORTURE_QEMU_MAC
>  # and TORTURE_QEMU_INTERACTIVE environment variables.
>  identify_qemu_args () {
> +	local KVM_CPU=""
> +	case "$1" in
> +	qemu-system-x86_64)
> +		KVM_CPU=kvm64
> +		;;
> +	qemu-system-i386)
> +		KVM_CPU=kvm32
> +		;;
> +	esac
>  	case "$1" in
>  	qemu-system-x86_64|qemu-system-i386)
> +		echo -machine q35,accel=kvm
> +		echo -cpu ${KVM_CPU},x2apic=on,tsc-deadline=on,hypervisor=on,tsc_adjust=on
>  		;;
>  	qemu-system-aarch64)
>  		echo -machine virt,gic-version=host -cpu host
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
> index d2d2a86139db1..322d5d40443cd 100644
> --- a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
> @@ -1,2 +1,6 @@
>  CONFIG_RCU_TORTURE_TEST=y
>  CONFIG_PRINTK_TIME=y
> +CONFIG_HYPERVISOR_GUEST=y
> +CONFIG_PARAVIRT=y
> +CONFIG_PARAVIRT_SPINLOCKS=y
> +CONFIG_KVM_GUEST=y
> -- 
> 2.20.1
> 

