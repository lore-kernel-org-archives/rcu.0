Return-Path: <SRS0=e+uF=U6=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831AAC5B578
	for <rcu@archiver.kernel.org>; Mon,  1 Jul 2019 20:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B672146F
	for <rcu@archiver.kernel.org>; Mon,  1 Jul 2019 20:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfGAU3d (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 1 Jul 2019 16:29:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48814 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726509AbfGAU3d (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 1 Jul 2019 16:29:33 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x61KTShR060549;
        Mon, 1 Jul 2019 16:29:31 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tfqjbbxk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Jul 2019 16:29:30 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x61KP38p002639;
        Mon, 1 Jul 2019 20:27:25 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01dal.us.ibm.com with ESMTP id 2tdym6s9te-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Jul 2019 20:27:25 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x61KROMP52298082
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Jul 2019 20:27:24 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57603B2064;
        Mon,  1 Jul 2019 20:27:24 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B597B205F;
        Mon,  1 Jul 2019 20:27:24 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  1 Jul 2019 20:27:24 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 597D216C362C; Mon,  1 Jul 2019 13:27:27 -0700 (PDT)
Date:   Mon, 1 Jul 2019 13:27:27 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org
Subject: Re: [RFC 3/3] Revert "rcutorture: Tweak kvm options"
Message-ID: <20190701202727.GR26519@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190701040415.219001-1-joel@joelfernandes.org>
 <20190701040415.219001-3-joel@joelfernandes.org>
 <20190701122358.nzebpuunp6o5jxhx@linutronix.de>
 <20190701141403.GA246562@google.com>
 <CACT4Y+bJ-tNvMsfHcFEsWdjtBnaLTP9q=u7PCk4VMVPvW51WLQ@mail.gmail.com>
 <20190701145920.GA71270@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701145920.GA71270@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-01_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907010237
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jul 01, 2019 at 10:59:20AM -0400, Joel Fernandes wrote:
> On Mon, Jul 01, 2019 at 04:48:43PM +0200, Dmitry Vyukov wrote:
> > On Mon, Jul 1, 2019 at 4:14 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > >
> > > On Mon, Jul 01, 2019 at 02:23:58PM +0200, Sebastian Andrzej Siewior wrote:
> > > > On 2019-07-01 00:04:15 [-0400], Joel Fernandes (Google) wrote:
> > > > > This reverts commit a6fda6dab93c2c06ef4b8cb4b9258df6674d2438 which
> > > > > causes kvm.sh to not run on my machines. The qemu-system-x86_64 command
> > > > > runs but does nothing.
> > > >
> > > > Nope. I would like to know *why* you need 'noapic' to work. Is it a
> > > > brand new or old qemu-system-x86_64?
> > >
> > > I did not have time to debug yesterday and I posted this particular revert as
> > > an 'RFC' just to make aware of this problem.
> > >
> > > I spent some more time just now, it looks like this has nothing to do with
> > > 'noapic' and appears to be a problem on debian distros with the e1000e NIC.
> > > May be this NIC was added to the virtual hardware because of -machine in the
> > > patch?
> > >
> > > Any if I add the following to the qemu command that kvm.sh runs, it works again:
> > > -net nic,model=e1000
> > >
> > > Without it I get:
> > >  qemu-system-x86_64: Initialization of device e1000e failed: failed to find romfile "efi-e1000e.rom"
> > >
> > > Seems to be mentioned here:
> > > https://bugs.launchpad.net/ubuntu/+source/ipxe/+bug/1737211
> > >
> > > And in syzkaller as well:
> > > https://github.com/google/syzkaller/blob/master/vm/qemu/qemu.go#L88
> > >
> > > Adding Dmitry who is syzkaller owner for any thoughts as well.
> > 
> > I don't have many thoughts on this. That particular error looked like
> > a bug in the package in the particular distro/version.
> 
> Paul, what is your preference here? Can we add the -net nic,model=e1000 to
> fix it for the benefit of any other Debian folks running kvm.sh?
> 
> Or do you prefer if I just built my own custom Qemu? I can't upgrade Qemu on
> this machine unfortunately. But may be I can build my own.
> 
> I prefer the -net option since I can save the time for something else. ;) Let
> me know what you prefer and I'll fix it accordingly.

Why not just add the following to your kvm.sh command line?

	--qemu-args "-net nic,model=e1000"

Easy workaround and no need to wait for changes to hit mainline.

Yes, I am perhaps naively assuming that the qemu bug in Debian will
be fixed in about the time that it would take for any change to the
rcutorture scripting to make its way into mainline.  ;-)

							Thanx, Paul
